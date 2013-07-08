# == Class updatemotd::params
#
# This class is meant to be called from updatemotd
# It sets variables according to platform
#
class updatemotd::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'updatemotd'
      $service_name = 'updatemotd'
    }
    'RedHat', 'Amazon': {
      $package_name = 'updatemotd'
      $service_name = 'updatemotd'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
