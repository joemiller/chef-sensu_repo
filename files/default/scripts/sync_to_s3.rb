#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), 'settings')

system "s3cmd --acl-public --delete-removed --follow-symlinks \
  sync #{REPO_BASE}/html/ s3://#{S3_BUCKET}/"
