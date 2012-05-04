#!/usr/bin/env ruby

# TODO: do something less ghetto with the supported rhel versions

require 'pty'
require 'expect'
require 'fileutils'

require File.join(File.dirname(__FILE__), 'settings')

def usage
  puts "Usage: #{$0} repo file1.rpm [[file2.rpm] ... [fileX.rpm]]"
  puts
  puts "repo examples:"
  puts "  - /yum              (the main repo)"
  puts "  - /yum-unstable     (the testing/beta repo)"
  exit 1
end

def sign_rpm(rpm)
  puts "Signing '#{rpm}' with key '#{GPG_KEY}'..."
  PTY.spawn("rpm --resign --define '_gpg_name #{GPG_KEY}' #{rpm}") do |cmd_out, cmd_in, pid|
    cmd_out.expect(/phrase/) { |r| cmd_in.printf "\n" }
    #puts cmd_out.read
  end
end

if $0 == __FILE__
  if ARGV.empty?
    usage
  end

  repo = ARGV.shift
  unless repo =~ /^\//
    puts "Invalid repo: '#{repo}'"
    usage
  end

  repo_path = "#{REPO_BASE}/html/#{repo}"

  ARGV.each do |rpm|

    rpm_basename = File.basename(rpm)

    arch = ''
    if rpm =~ /i386/
      arch = 'i386'
    elsif rpm =~ /x86_64/
      arch = 'x86_64'
    elsif rpm =~ /noarch/
      arch = 'noarch'
    end

    if arch == ''
      puts "Errror: couldn't determine architecture of rpm '#{rpm}'. skipping"
    else
      FileUtils.cp(rpm, "#{repo_path}/el/5/#{arch}/#{rpm_basename}")
      FileUtils.cp(rpm, "#{repo_path}/el/6/#{arch}/#{rpm_basename}")
      # sign_rpm("#{repo_path}/el/5/#{arch}/#{rpm_basename}")
      # sign_rpm("#{repo_path}/el/6/#{arch}/#{rpm_basename}")
    end  
  end

  %w[ i386 x86_64 noarch ].each do |arch|
    system "createrepo #{repo_path}/el/5/#{arch}/"
    system "createrepo #{repo_path}/el/6/#{arch}/"
  end

  ## load and run our sync_to_s3 script
  require File.join(File.dirname(__FILE__), 'sync_to_s3')
end