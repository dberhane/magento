Exec { path => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ] }

include bootstrap
include apache
include tools
include php
include php::pear
include php::pecl
include mysql
include git

#include known_hosts
#include drupal::drush
#include drupal
#include samba