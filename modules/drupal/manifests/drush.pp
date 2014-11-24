class drupal::drush {
  exec { "download-drush":
    cwd => "/tmp",
    command => "/usr/bin/wget https://github.com/drush-ops/drush/archive/6.x.zip",
    creates => "/tmp/6.x.zip",
  }
  
  exec { "install-drush":
    cwd => "/usr/local/",
    command => "/usr/bin/unzip /tmp/6.x.zip && /bin/mv drush-6.x drush",
    creates => "/usr/local/drush",
    require => [Exec["download-drush"], Package['zip']],
  }
  
  # a fuller example, including permissions and ownership
file { "/usr/local/drush":
    ensure => "directory",
    owner  => "vagrant",
    group  => "root",
    recurse => true,
    require => Exec["install-drush"],
}

  
exec { "symlink-drush":
  command => "/bin/ln -s /usr/local/drush/drush /usr/local/bin/drush",
  creates => "/usr/local/bin/drush",
}

}