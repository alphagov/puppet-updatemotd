# == Define: updatemotd::script
#
# Define a script to be included by motd(5) / update-motd(5). The contents
# should be executable and write to STDOUT.
#
# === Parameters
#
# [*order*]
#   Two digit integer between 00 and 99. This is the order which the file
#   will be included in the motd output.
#   Default: 50
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
#
define updatemotd::script(
  $order = 50,
  $source = undef,
  $content = undef
) {
  validate_re($title, '^[a-zA-Z_]+$')
  validate_re($order, '^[0-9]{2}$')

  if !($source) and !($content) {
    fail('source or content params are required')
  } elsif ($source) and ($content) {
    fail('source and content params are mutually exclusive')
  }

  include updatemotd::params

  file { "${updatemotd::params::config_dir}/${order}-${title}":
    ensure  => present,
    mode    => '0755',
    source  => $source,
    content => $content,
    require => Class['updatemotd'],
  }
}
