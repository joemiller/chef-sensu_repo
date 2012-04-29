#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), 'settings')

system "s3cmd --acl-public --delete-removed sync #{REPO_BASE}/ s3://#{S3_BUCKET}/"
