class magento ( $db_username, $db_password, $admin_username, $admin_password) {

# a fuller example, including permissions and ownership
  file { ["/opt/sites", "/opt/sites/php"]:
    ensure  => "directory",
    owner   => "vagrant",
    group   => "vagrant",
    mode    => 755,
    recurse => true,
  }

# test page whether all php modules are installed correctly
  file { "/opt/sites/php/index.php":
    ensure  => present,
    source => 'puppet:///modules/magento/index.php',
    require => [Package["apache2"], File["/opt/sites", "/opt/sites/php"]],
  }

  exec { "download-unzip-magento":
    cwd     => "/opt/sites",
    command => "/usr/bin/wget http://www.magentocommerce.com/downloads/assets/1.9.0.1/magento-1.9.0.1.tar.gz && /bin/tar zxvf magento-1.9.0.1.tar.gz",
    timeout => 0,
    creates => "/opt/sites/magento/index.php",
  }


# permission for media and var directories
  file { ["/opt/sites/magento/media", "/opt/sites/magento/var"]:
    owner   => "vagrant",
    mode    => "667",
    recurse => true,
    require => Exec["download-unzip-magento"],
  }

# permission for media and var directories
  file { ["/opt/sites/magento/app/etc"]:
    ensure  => "directory",
    owner   => "vagrant",
    mode    => 667,
    require => Exec["download-unzip-magento"],
  }

# install magento
  exec { "install-magento":
    cwd     => "/opt/sites/magento",
    creates => "/opt/sites/magento/app/etc/local.xml",
    command => "/usr/bin/php -f install.php --
    --license_agreement_accepted \"yes\"
    --locale \"en_UK\" --timezone \"Europe/London\"
    --default_currency \"GBP\"
    --db_host \"localhost\" --db_name \"magentodb\"
    --db_user \"root\" --db_pass \"root\"
    --url \"http://127.0.0.1:8080/magento\"
    --use_rewrites \"yes\" --use_secure \"no\"
    --secure_base_url \"http://127.0.0.1:8080/magento\"
    --use_secure_admin \"no\" --skip_url_validation \"yes\"
    --admin_firstname \"Store\" --admin_lastname \"Owner\"
    --admin_email \"dberhane@gmail.com\" --admin_username \"admin\" --admin_password \"123password\"",
    require => [Exec["download-unzip-magento"]],
  }

}