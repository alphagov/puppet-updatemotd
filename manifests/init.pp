# == Class: updatemotd
#
# Full description of class updatemotd here.
#
# === Parameters
#
# [*purge_directory*]
#   Boolean flag to purge the unmanaged contents of the config directory.
#   This will remove any standard system entries.
#   Default: false
#
class updatemotd (
  $purge_directory = false
) inherits updatemotd::params {

  validate_bool($purge_directory)

  anchor { 'updatemotd::begin': } ->
  class { 'updatemotd::install': } ->
  class { 'updatemotd::config': } ->
  anchor { 'updatemotd::end': }
}
