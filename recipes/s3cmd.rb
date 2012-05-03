# package "s3cmd" do
#   action :install
# end

s3cmd_source_url = "https://github.com/s3tools/s3cmd/tarball/master"

bash "install-s3cmd" do
  user "root"
  cwd Chef::Config['file_cache_path']
  code <<-EOH
    tar -zxf s3cmd.tar.gz
    mkdir s3cmd
    tar zxf s3cmd.tar.gz --strip-components 1 -C s3cmd
  EOH
  action :nothing
end

remote_file "#{Chef::Config['file_cache_path']}/s3cmd.tar.gz" do
  source s3cmd_source_url
  mode 0644
  notifies :run, "bash[install-s3cmd]", :immediately
end
