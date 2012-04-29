include_recipe "sensu_repo::user"
include_recipe "git"
include_recipe "apt"

apt_repository "freight" do
  uri "http://packages.rcrowley.org"
  distribution node['lsb']['codename']
  components ["main"]
  key "http://packages.rcrowley.org/keyring.gpg"
  action :add
end

%w[dpkg make freight].each do |pkg|
  package pkg do
    action :install
  end
end

template "/etc/freight.conf" do
  owner  "root"
  group  "root"
  mode   0644
  source "freight.conf.erb"
end

directory "#{node.sensu_repo.base_dir}/html/apt" do
  owner     node.sensu_repo.user
  group     node.sensu_repo.user
  mode      "0755"
  recursive true
  action    :create
end

directory "#{node.sensu_repo.base_dir}/freight" do
  owner node.sensu_repo.user
  group node.sensu_repo.user
  mode  0755
end
