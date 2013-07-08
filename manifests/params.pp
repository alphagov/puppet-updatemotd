# == Class updatemotd::params
#
# This class is meant to be called from updatemotd
# It sets variables according to platform
#
class updatemotd::params {
  case $::osfamily {
    'Debian': {
      $package_name  = 'libpam-modules'
      $package_purge = 'update-motd'
      $config_dir    = '/etc/update-motd.d'
      $motd_symlink  = '/var/run/motd'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
