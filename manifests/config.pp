# == Class updatemotd::config
#
# This class is called from updatemotd
#
class updatemotd::config {
  include updatemotd::params

  file { $updatemotd::params::config_dir:
    ensure => directory,
  }
}
