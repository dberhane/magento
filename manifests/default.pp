Exec { path => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ] }


# magento config
class { "magento":

/* magento database settings */
  db_username    => "root",
  db_password    => "root",

/* magento admin user */
  admin_username => "admin",
  admin_password => "123password",

}

include bootstrap
include apache
include tools
include php
#include php::pear
#include php::pecl
#include mysql
#include git
include magento

