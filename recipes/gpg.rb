#
# Cookbook Name:: sensu_repo
# Recipe:: gpg
#
# Copyright 2011, AJ Christensen
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "sensu_repo::user"

unless system("sudo -u #{node.sensu_repo.user} -i gpg --list-keys #{node.sensu_repo.gpg.name.real}")
  package "haveged"

  service "haveged" do
    supports [:status, :restart]
    action :start
  end

  file node.sensu_repo.gpg.batch_config do
    content <<-EOS
Key-Type: #{node.sensu_repo.gpg.key_type}
Key-Length: #{node.sensu_repo.gpg.key_length}
Name-Real: #{node.sensu_repo.gpg.name.real}
Name-Comment: #{node.sensu_repo.gpg.name.comment}
Name-Email: #{node.sensu_repo.gpg.name.email}
Expire-Date: #{node.sensu_repo.gpg.expire.date}
%commit
EOS
  end

  execute "gpg: generate" do
    command "sudo -u #{node.sensu_repo.user} -i gpg --gen-key --batch #{node.sensu_repo.gpg.batch_config}"
  end

  service "haveged" do
    action :stop
  end

  package "haveged" do
    action :purge
  end
end
