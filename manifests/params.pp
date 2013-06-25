#Parameters class for the memcached module
class memcached::params {
  $memcached_port = '11211'
  $maxconn = '1024'
  $cachesize = '64'
  $memcached_options = ''

  case $::osfamily {
    'redhat': {
      $memcached_user = 'memcached'
      $memcached_config_file = '/etc/sysconfig/memcached'
      $memcached_template_file = 'memcached/memcached.sysconfig.erb'
    }
    'debian': {
      $memcached_user = 'nobody'
      $memcached_config_file = '/etc/memcached.conf'
      $memcached_template_file = 'memcached/memcached.debian.erb'
    }
    default: {
      $memcached_user = 'nobody'
      $memcached_config_file = '/etc/memcached'
      $memcached_template_file = 'memcached/memcached.sysconfig.erb'
    }
  }
}
