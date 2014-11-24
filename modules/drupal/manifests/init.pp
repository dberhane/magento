class drupal {

# a fuller example, including permissions and ownership
  file { ["/opt/sites", "/opt/sites/drupal"]:
    ensure  => "directory",
    owner   => "vagrant",
    group   => "vagrant",
    mode    => 755,
    recurse => true,
  }

# HW The BMJ site root folder
  file { "/opt/sites/hw":
    ensure  => "directory",
    owner   => "vagrant",
    group   => "vagrant",
    mode    => 755,
    recurse => true,
  }

# Include Drupal settings.php
  file{ '/opt/sites/hw/settings.php' :
    ensure => present,
    owner  => "vagrant",
    group  => "vagrant",
    source => 'puppet:///modules/drupal/settings.php',
  }


  file { "/opt/sites/hw/files":
    ensure => "directory",
    owner  => "vagrant",
    group  => "vagrant",
    mode   => 777,
  }


# BMJ and HW modules, themes symlinks syntax
  file { '/opt/sites/hw/drupal-webroot/sites/default/scripts':
    ensure  => 'link',
    owner   => "vagrant",
    group   => "vagrant",
    target  => '/opt/sites/hw/drupal-site-jnl-bmj/scripts',
    require => [vcsrepo["/opt/sites/hw/drupal-webroot"], vcsrepo["/opt/sites/hw/drupal-site-jnl-bmj"]],
  }

  file { '/opt/sites/hw/drupal-webroot/sites/default/files':
    ensure  => 'link',
    owner   => "vagrant",
    group   => "vagrant",
    target  => '/opt/sites/hw/files',
    require => [vcsrepo["/opt/sites/hw/drupal-webroot"], File["/opt/sites/hw/files"]],
  }

  file { '/opt/sites/hw/drupal-webroot/sites/default/libraries':
    ensure  => 'link',
    owner   => "vagrant",
    group   => "vagrant",
    target  => '../../../drupal-site-jnl-bmj/libraries',
    require => [vcsrepo["/opt/sites/hw/drupal-webroot"], vcsrepo["/opt/sites/hw/drupal-site-jnl-bmj"]],
  }

  file { '/opt/sites/hw/drupal-webroot/sites/default/modules':
    ensure  => 'link',
    owner   => "vagrant",
    group   => "vagrant",
    target  => '../../../drupal-site-jnl-bmj/modules',
    require => [vcsrepo["/opt/sites/hw/drupal-webroot"], vcsrepo["/opt/sites/hw/drupal-site-jnl-bmj"]],
  }

  file { '/opt/sites/hw/drupal-webroot/sites/default/themes':
    ensure  => 'link',
    owner   => "vagrant",
    group   => "vagrant",
    target  => '../../../drupal-site-jnl-bmj/themes',
    require => [vcsrepo["/opt/sites/hw/drupal-webroot"], vcsrepo["/opt/sites/hw/drupal-site-jnl-bmj"]],
  }

  file { '/opt/sites/hw/drupal-webroot/sites/all/modules/highwire':
    ensure  => 'link',
    owner   => "vagrant",
    group   => "vagrant",
    target  => '../../../../drupal-highwire/modules',
    require => [vcsrepo["/opt/sites/hw/drupal-webroot"], vcsrepo["/opt/sites/hw/drupal-highwire"]],
  }

  file { '/opt/sites/hw/drupal-webroot/sites/all/themes/highwire':
    ensure  => 'link',
    owner   => "vagrant",
    group   => "vagrant",
    target  => '../../../../drupal-highwire/themes',
    require => [vcsrepo["/opt/sites/hw/drupal-webroot"], vcsrepo["/opt/sites/hw/drupal-highwire"]],
  }

  file { '/opt/sites/hw/drupal-webroot/sites/default/settings.php':
    ensure  => 'link',
    owner   => "vagrant",
    group   => "vagrant",
    target  => '../../../settings.php',
    require => [vcsrepo["/opt/sites/hw/drupal-webroot"], file["/opt/sites/hw/settings.php"]],
  }

  exec { "create-drupal-db":
    unless  => "/usr/bin/mysql -uroot -proot drupal",
    command => "/usr/bin/mysql -uroot -proot -e \"create database drupal; grant all on drupal.* to root@localhost identified by 'root';\"",
    require => Service["mysql"],
  }

  exec { "install-drupal":
    cwd     => "/opt/sites/drupal",
    command => "/usr/local/bin/drush -y dl drupal-7.31 --destination='/opt/sites' --drupal-project-rename='drupal' && /usr/local/bin/drush site-install -r '/opt/sites/drupal' standard --account-name=admin --account-pass='19bmjpg' --db-url='mysql://root:root@localhost/drupal'",
    require => [File["/opt/sites/drupal"], Class["drupal::drush"], Exec["create-drupal-db"]],
  }

  exec { "install-registry-rebuild":
    cwd     => "/home/vagrant",
    command => "/usr/local/bin/drush -y dl registry_rebuild",
    require => [Class["drupal::drush"]],
  }

  vcsrepo { "/opt/sites/hw/drupal-highwire":
    ensure   => latest,
    owner    => vagrant,
    user     => root,
    group    => vagrant,
    provider => git,
    require  =>  [Package['git'], File['/opt/sites/hw']],
    source   => "git@github.com:highwire/drupal-highwire.git",
    revision => '7.x-1.x-stable',
  }

  vcsrepo { "/opt/sites/hw/drupal-webroot":
    ensure   => latest,
    owner    => vagrant,
    user     => root,
    group    => vagrant,
    provider => git,
    require  =>  [Package['git'], File['/opt/sites/hw']],
    source   => "git@github.com:highwire/drupal-webroot.git",
    revision => '7.x-1.x-stable',
  }


  vcsrepo { "/opt/sites/hw/drupal-site-jnl-bmj":
    ensure   => latest,
    owner    => vagrant,
    user     => root,
    group    => vagrant,
    provider => git,
    require  =>  [Package['git'], File['/opt/sites/hw']],
    source   => "git@github.com:highwire/drupal-site-jnl-bmj.git",
    revision => '7.x-1.x-dev',
  }


}



