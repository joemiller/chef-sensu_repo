#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), 'settings')

def usage
  puts "Usage: #{$0} dist/component file1.deb [[file2.deb] ... [fileX.deb]]"
  puts
  puts "dist/component examples:"
  puts "  - sensu/main"
  puts "  - sensu/unstable"
  exit 1
end

if __FILE__ == $0
  if ARGV.empty?
    usage
  end

  repo = ARGV.shift
  unless repo =~ /\//
    puts "Invalid dist/component: '#{repo}'"
    usage
  end

  ARGV.each do |deb|
    system "freight add #{deb} apt/#{repo}"
  end

  system "freight cache"

  ## load and run our sync_to_s3 script
  require sync_to_s3_script = File.join(File.dirname(__FILE__), 'sync_to_s3')

  # ex:
  # freight add sensu_0.9.5-35_amd64.deb apt/sensu
  # freight add sensu_0.9.5-35_i386.deb apt/sensu
  # freight cache
end
