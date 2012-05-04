include_recipe "sensu_repo::user"

%w[ rpm createrepo ].each do |pkg|
  package pkg do
    action :install
  end
end

# setup multiple repos - 
#   the main ('/') yum repo
#       eg: http://repos.sensuapp.org/yum/...
#   the 'unstable' yum repo
#       eg: http://repos.sensuapp.org/yum-unstable/...

%w[ yum yum-unstable ].each do |repo|

  directory "#{node.sensu_repo.base_dir}/html/#{repo}" do
    owner     node.sensu_repo.user
    group     node.sensu_repo.user
    mode      "0755"
    recursive true
    action    :create
  end

  %w[ el
      el/5
      el/6
      el/5/i386
      el/5/x86_64
      el/5/noarch
      el/6/i386
      el/6/x86_64
      el/6/noarch
  ].each do |dir|

    directory "#{node.sensu_repo.base_dir}/html/#{repo}/#{dir}" do
      owner     node.sensu_repo.user
      group     node.sensu_repo.user
      mode      "0755"
      recursive true
      action    :create
    end

  end

end
