# == Class: updatemotd
#
# Manages MOTD on Ubuntu-alike systems using the update-motd model of conf.d
# files.
#
# === Parameters
#
# [*purge_directory*]
#   Boolean flag to purge the unmanaged contents of the config directory.
#   Depending on the setting of `preserve_upstream` this may remove upstream
#   OS scipts.
#   Default: false
#
# [*preserve_upstream*]
#   Boolean flag to preserve scripts from the upstream OS when
#   `purge_directory` is used.
#   Default: true
#
class updatemotd (
  $purge_directory = false,
  $preserve_upstream = true
) inherits updatemotd::params {

  validate_bool($purge_directory, $preserve_upstream)

  anchor { 'updatemotd::begin': } ->
  class { 'updatemotd::install': } ->
  class { 'updatemotd::config': } ->
  anchor { 'updatemotd::end': }
}
