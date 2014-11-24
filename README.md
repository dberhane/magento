# The BMJ Drupal site 

## Description

Vagrant and Puppet provisioner script which deploys Magento local development environment:

 - 64 bit Trusty
 - full lamp stack (PHP, PEAR, PECL, MySQL, Memcached, Git, etc..)
 
## Requirements

### Platform:
Tested on Ubuntu 14.04 (Trusty Tahr)

### Installation 

(The Puppet script was tested on Virtualbox 4.3.18 and Vagrant 1.6.5)

- Install Virtualbox 4.3.18 

- Install Vagrant 1.6.5 

- Install Vagrant hostsupdater to add update windows hosts file (vagrant plugin install vagrant-hostsupdater)

  
## Usage

Download or clone this git repo and change to the directory and run

- Review Vagrant file setting

- Run vagrant up


Puppet script for The Magento local Drupal development environment

Author:: Daniel Berhane (<dberhane@gmail.com>)