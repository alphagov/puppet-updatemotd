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
  class { 'updatemotd::config': } ->
  anchor { 'updatemotd::end': }
}
