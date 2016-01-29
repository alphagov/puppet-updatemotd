# == Define: updatemotd::script
#
# Define a script to be included by motd(5) / update-motd(5). The contents
# should be executable and write to STDOUT. If you only need static content
# then please see the parent class.
#
# === Parameters
#
# [*order*]
#   Two digit string between 00 and 99. This is the order which the file
#   will be included in the motd output.
#   Default: '50'
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
  $order = '50',
  $source = undef,
  $content = undef
) {
  validate_re($title, '^[a-zA-Z_]+$')

  # for backwards compatibility with puppet 3 users coerce int to string
  $order_string = sprintf('%s', $order)

  validate_re($order_string, '^[0-9]{2}$')

  if !($source) and !($content) {
    fail('source or content params are required')
  } elsif ($source) and ($content) {
    fail('source and content params are mutually exclusive')
  }

  include updatemotd::params

  file { "${updatemotd::params::config_dir}/${order_string}-${title}":
    ensure  => present,
    mode    => '0755',
    source  => $source,
    content => $content,
    require => Class['updatemotd'],
  }
}
