#
# Class: memcached
#
# A module to install and configure memcached on a node.
# It defaults to the usual memcached configuration settings but they can all be changed
# by passing the parameters to the class.
#
# Example:
# class { "memcached":
#   memcached_port => '11211',
#   maxconn        => '2048',
#   cachesize      => '20000',
# }
#

class memcached (
  $memcached_user = $memcached::params::memcached_user,
  $memcached_port = $memcached::params::memcached_port,
  $maxconn = $memcached::params::maxconn,
  $cachesize = $memcached::params::cachesize,
  $memcached_options = $memcached_options,
) inherits memcached::params {
  $memcached_config_file = $memcached::params::memcached_config_file
  $memcached_template_file = $memcached::params::memcached_template_file

  package { 'memcached':
    ensure => installed
  }

  file { $memcached_config_file:
    ensure  => present,
    mode    => '0444',
    owner   => root,
    group   => root,
    content => template($memcached_template_file),
    require => Package['memcached'],
    notify  => Service['memcached']
  }

  service { 'memcached':
    ensure     => true,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => [File[$memcached_config_file],Package['memcached']],
  }
}
