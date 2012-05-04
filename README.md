chef-sensu_repo
===============

This repo contains all of the tools, files, and configs to setup a 
machine to manage the Sensu package (yum/apt) repos.

Note: This class does not setup a webserver to serve the files directly, instead it
syncs the repos to S3.


TODO
----

- add support for additional 'unstable' repo (see details below)
- implement rpm signing
- provide .repo files or .rpm's for people to easily download and register the yum
  repos (or .rpm's like epel does)



Specs/Design for supporting an additional repo ('unstable')
-----------------------------------------------------------

### apt

- Keep existing url base? - http://repos.sensuapp.org/apt

- Use new 'component' to select unstable or main. eg:

	sensu/main	- existing repo. remains to provide official/final tested versions
	sensu/unstable - new repo. will include betas or nightlies, etc

- Example apt sources for both repos:

	deb http://repos.sensuapp.org/apt sensu main
	deb http://repos.sensuapp.org/apt sensu unstable

- Update `apt_add_debs.rb` script to require new 1st argument to specify
  the repo, eg:  `apt_add_debs.rb sensu/main file1.deb [file2.deb...fileX.deb]

### yum

- New url's, subdir of /yum?  http://repos.sensuapp.org/yum/unstable

	http://repos.sensuapp.org/yum/unstable/el/$releasever/$arch

- Example yum .repo files's for both

	...
	baseurl=http://repos.sensuapp.org/yum/el/$releasever/$basearch/
	...
	baseurl=http://repos.sensuapp.org/yum-unstable/el/$releasever/$basearch/

- Update `yum_add_debs.rb` script to require new 1st argument to specify
  the repo, eg:  `yum_add_debs.rb /yum file1.rpm [file2.rpm...fileX.deb]` or
  `yum_add.rpms.rb /yum-unstable file1.rpm ...
