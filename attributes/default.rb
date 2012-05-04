default.sensu_repo.base_dir = "/repo"
default.sensu_repo.user = 'repo'
default.sensu_repo.s3_bucket = 'repos.sensuapp.org'

default.sensu_repo.apt.origin = 'Sensu'
default.sensu_repo.apt.label = 'Sensu'

default.sensu_repo.gpg.name.real "Sonian Inc"
default.sensu_repo.gpg.name.comment "Sensu signing key"
default.sensu_repo.gpg.name.email "chefs@sonian.net"
default.sensu_repo.gpg.expire.date "0"
default.sensu_repo.gpg.batch_config "/tmp/gpg_batch_config"

default.sensu_repo.gpg.key_type = "RSA"
default.sensu_repo.gpg.key_length = "2048"

# (May 2012) due to a bug in --follow-symlinks, we need a newer version
# of s3cmd from the git repo. Until this is resolved and the distros release
# new packages, we install s3cmd from source
default.sensu_repo.s3cmd.source_url = "https://github.com/s3tools/s3cmd/tarball/master"
