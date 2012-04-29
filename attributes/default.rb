default.sensu_repo.base_dir = "/repo"
default.sensu_repo.user = 'repo'
default.sensu_repo.s3_bucket = 'repos.sensuapp.org'

default.sensu_repo.apt.origin = 'Sensu'
default.sensu_repo.apt.label = 'Sensu'
default.sensu_repo.apt.distro = "apt/sensu"

default.sensu_repo.gpg.name.real "Sensu Package Maintainer"
default.sensu_repo.gpg.name.comment "package signing key"
default.sensu_repo.gpg.name.email "testingonly@joemiller.me"
default.sensu_repo.gpg.expire.date "0"
default.sensu_repo.gpg.batch_config "/tmp/gpg_batch_config"

default.sensu_repo.gpg.key_type = "RSA"
default.sensu_repo.gpg.key_length = "2048"
