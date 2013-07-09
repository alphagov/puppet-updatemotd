# == Class: updatemotd
#
# Manages MOTD on Ubuntu-alike systems using the update-motd model of conf.d
# files. Static content can be appended to the MOTD by passing params to
# this class. See the `updatemotd::script` defined type if you need more
# control.
#
# === Parameters
#
# [*source*]
#   Standard `source` param for a file resource. This is mutually exclusive
#   to the `content` param.
#   Default: undef
#
# [*content*]
#   Standard `content` param for a file resource. This is mutually exclusive
#   to the `source` param.
#   Default: undef
#
# [*purge_directory*]
#   Boolean flag to purge the unmanaged contents of the config directory.
#   Depending on the setting of `preserve_upstream` this may remove upstream
#   OS scipts.
#   Default: false
#
# [*preserve_upstream*]
#   Boolean flag to preserve scripts from the upstream OS when
#   `purge_directory` is used. Changing this may break the behaviour of
#   `source`/`content`.
#   Default: true
#
class updatemotd (
  $source = undef,
  $content = undef,
  $purge_directory = false,
  $preserve_upstream = true
) inherits updatemotd::params {

  if ($source) and ($content) {
    fail('source and content params are mutually exclusive')
  }
  validate_string($source, $content)
  validate_bool($purge_directory, $preserve_upstream)

  anchor { 'updatemotd::begin': } ->
  class { 'updatemotd::install': } ->
  class { 'updatemotd::config': } ->
  anchor { 'updatemotd::end': }
}
