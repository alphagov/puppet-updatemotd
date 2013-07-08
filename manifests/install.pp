# == Class updatemotd::intall
#
class updatemotd::install {
  include updatemotd::params

  package { $updatemotd::params::package_name:
    ensure => present,
  }
}
