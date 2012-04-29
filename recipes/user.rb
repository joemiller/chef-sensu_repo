user node.sensu_repo.user do
  comment "repo manager"
  system  true
  shell   "/bin/sh"
  home    node.sensu_repo.base_dir
  supports :manage_home => true
  action  :create
end

directory "#{node.sensu_repo.base_dir}/html" do
  owner     node.sensu_repo.user
  group     node.sensu_repo.user
  mode      0755
  recursive true
  action    :create
end

template "#{node.sensu_repo.base_dir}/README.md" do
  owner     node.sensu_repo.user
  group     node.sensu_repo.user
  mode      0644
  source    "README.md.erb"
end
