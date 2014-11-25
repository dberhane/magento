class bootstrap {

 File { owner => 0, group => 0, mode => 0644 }

  # silence puppet and vagrant annoyance about the puppet group
  group { 'puppet':
    ensure => 'present'
  }

  # ensure local apt cache index is up to date before beginning
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

  # get PHP5.4 from oldstable sources
  exec { 'apt-get update ppa':
    command => '/usr/bin/add-apt-repository ppa:ondrej/php5-oldstable -y'
  }

#  exec { 'apt-get dist-upgrade':
#    command => '/usr/bin/apt-get dist-upgrade'
#  }


}