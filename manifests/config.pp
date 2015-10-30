# == Class updatemotd::config
#
# This class is called from updatemotd
#
class updatemotd::config {
  include updatemotd::params

  $source            = $updatemotd::source
  $content           = $updatemotd::content
  $purge_directory   = $updatemotd::purge_directory
  $preserve_upstream = $updatemotd::preserve_upstream

  $config_dir        = $updatemotd::params::config_dir
  $motd_symlink      = $updatemotd::params::motd_symlink

  file { '/etc/motd':
    ensure => link,
    target => $motd_symlink,
  }

  if !($source) and !($content) {
    $tail_ensure = absent
  } else {
    $tail_ensure = present
  }
  file { '/etc/motd.tail':
    ensure  => $tail_ensure,
    source  => $source,
    content => $content,
  }

  file { $config_dir:
    ensure  => directory,
    recurse => true,
    force   => true,
    purge   => $purge_directory,
  }

  if $preserve_upstream {
    $upstream_files     = $updatemotd::params::upstream_files
    $upstream_files_abs = prefix($upstream_files, "${config_dir}/")

    # Marking these as undef tells Puppet not to purge them, nor care about
    # whether they currently exist or what they contain.
    file { $upstream_files_abs:
      ensure  => undef,
    }
  }
}
