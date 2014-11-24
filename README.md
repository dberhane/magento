# The BMJ Drupal site 

## Description

Vagrant and Puppet provisioner script which deploys Drupal local development environment for the BMJ site:

 - 64 bit Ubuntu Precise
 - full lamp stack (PHP, PEAR, PECL, MySQL, Memcached, Git, etc..)
 - downloads and configures HW Drupal Core, JCore and The BMJ code Github repositories

## Requirements

### Platform:
Tested on Ubuntu 12.04 (Precise Pangolin)

### Installation 

(The Puppet script was tested on Virtualbox 4.3.18 and Vagrant 1.6.5)

- Install Virtualbox 4.3.18 

- Install Vagrant 1.6.5 

- Install Vagrant hostsupdater to add update windows hosts file (vagrant plugin install vagrant-hostsupdater)

The Puppet single install script deploys The BMJ local dev site with empty database. Please follow the instructions on The BMJ redesign wiki

  http://bmj-redesign.internal.bmjgroup.com/index.php/Local_development_environment#Vagrant
  
## Usage

Download or clone this git repo and change to the directory and run

- Review Vagrant file setting and tweak your SSH / deploy key and VM settings

- Run vagrant up

=========
thebmjbox
=========

Puppet script for The BMJ local Drupal development environment

Author:: Daniel Berhane (<dberhane@bmj.com>)