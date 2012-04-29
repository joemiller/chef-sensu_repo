include_recipe "sensu_repo::user"

directory "#{node.sensu_repo.base_dir}/scripts" do
  owner     node.sensu_repo.user
  group     node.sensu_repo.user
  mode      "0755"
  action    :create
end

remote_directory "#{node.sensu_repo.base_dir}/scripts" do
  source      "scripts"
  files_owner "root"
  files_group "root"
  files_mode  0755
  mode        0755
end

template "#{node.sensu_repo.base_dir}/scripts/settings.rb" do
  owner   "root"
  mode    0644
  source  "settings.rb.erb"
end