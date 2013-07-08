# == Class updatemotd::service
#
# This class is meant to be called from updatemotd
# It ensure the service is running
#
class updatemotd::service {
  include updatemotd::params

  service { $updatemotd::params::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
