# == Class updatemotd::config
#
# This class is called from updatemotd
#
class updatemotd::config {
  include updatemotd::params

  $purge_directory = $updatemotd::purge_directory

  file { $updatemotd::params::config_dir:
    ensure  => directory,
    recurse => true,
    force   => true,
    purge   => $purge_directory,
  }
}
