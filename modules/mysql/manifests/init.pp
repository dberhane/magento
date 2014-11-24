class mysql {

  # root mysql password
  $mysqlpw = "root"

# get mysql server 5.6
  exec { 'apt-get mysql-server':
    command => '/usr/bin/apt-get -q -y install mysql-server-5.6'
  }

# get mysql client 5.6
  exec { 'apt-get mysql-client':
    command => '/usr/bin/apt-get -q -y install mysql-client-5.6'
  }

  #start mysql service
  service { "mysql":
    ensure => running,
    require => Exec["apt-get mysql-server"],
  }

  # set mysql password
  exec { "set-mysql-password":
    unless => "mysqladmin -uroot -p$mysqlpw status",
    command => "mysqladmin -uroot password $mysqlpw",
    require => Exec["apt-get mysql-server"],
  }

# set mysql password
  exec { "create-magentodb":
    unless => "/usr/bin/mysql -uroot -p$mysqlpw magentodb",
    command => "/usr/bin/mysql -uroot -p$mysqlpw -e \"create database magentodb; grant all on magentodb.* to root@localhost identified by 'root';\"",
    require => [Exec["apt-get mysql-server"], Exec["apt-get mysql-client"]],
  }

}