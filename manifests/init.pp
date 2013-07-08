# == Class: updatemotd
#
# Full description of class updatemotd here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class updatemotd (
) inherits updatemotd::params {

  # validate parameters here

  anchor { 'updatemotd::begin': } ->
  class { 'updatemotd::install': } ->
  class { 'updatemotd::config': }
  class { 'updatemotd::service': } ->
  anchor { 'updatemotd::end': }

  Anchor['updatemotd::begin']  ~> Class['updatemotd::service']
  Class['updatemotd::install'] ~> Class['updatemotd::service']
  Class['updatemotd::config']  ~> Class['updatemotd::service']
}
