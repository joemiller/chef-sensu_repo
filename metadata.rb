maintainer        "Joe Miller"
maintainer_email  "joeym@joeym.net"
license           "Apache 2.0"
description       "configures sensu-build box"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.1"

# available @ http://community.opscode.com/cookbooks/apt
depends "apt"

%w{ ubuntu debian }.each do |os|
  supports os
end
