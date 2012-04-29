include_recipe "sensu_repo::user"
include_recipe "apt"

%w[ rpm createrepo ].each do |pkg|
  package pkg do
    action :install
  end
end

%w[ yum
    yum/el
    yum/el/5
    yum/el/6
    yum/el/5/i386
    yum/el/5/x86_64
    yum/el/5/noarch
    yum/el/6/i386
    yum/el/6/x86_64
    yum/el/6/noarch
 ].each do |dir|

  directory "#{node.sensu_repo.base_dir}/html/#{dir}" do
    owner     node.sensu_repo.user
    group     node.sensu_repo.user
    mode      "0755"
    recursive true
    action    :create
  end
end