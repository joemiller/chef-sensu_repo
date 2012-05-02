#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), 'settings')

if ARGV.empty?
  puts "Usage: #{$0} file1.deb [[file2.deb] ... [fileX.deb]]"
  exit 1
end

ARGV.each do |deb|
  system "freight add #{deb} #{APT_DISTRO}"
end

system "freight cache"

## load and run our sync_to_s3 script
require sync_to_s3_script = File.join(File.dirname(__FILE__), 'sync_to_s3')

# ex:
# freight add sensu_0.9.5-35_amd64.deb apt/sensu
# freight add sensu_0.9.5-35_i386.deb apt/sensu
# freight cache
