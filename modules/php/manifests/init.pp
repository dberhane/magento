class php {

  # package install list
  $packages = [
    "php5",
    "php5-cli",
    "php5-curl",
    "php5-mysql",
    "php-pear",
    "php5-dev",
    "php5-gd",
    "php5-intl",
    "php5-imap",
    "php5-xsl",
    "php5-mcrypt",
    "php5-ming",
    "php5-memcache",
    "libapache2-mod-php5",
    "php5-ps",
    "php5-pspell",
    "php5-recode",
    "php5-snmp",
    "php5-sqlite",
    "php5-tidy",
    "php5-xmlrpc",
    "php-apc",
  ]

  package { $packages:
    ensure => present,
    require => [Exec["apt-get update"],Class["bootstrap"],Class["tools"],Package['apache2']],
  }

# override and increase memory limit
file {'/etc/php5/apache2/conf.d/memory_limit.ini':
  ensure => present,
  owner => root, group => root, mode => 444,
  content => "memory_limit =  1024M",
  require =>  [Package['apache2']],
}

# override and increase maximum upload size
file {'/etc/php5/apache2/conf.d/upload_limits.ini':
  ensure => present,
  owner => root, group => root, mode => 444,
  content => "post_max_size = 10M \nupload_max_filesize = 10M \n",
  require =>  [Package['apache2']],
}

}