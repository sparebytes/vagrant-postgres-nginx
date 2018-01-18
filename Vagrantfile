# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrant
$VAGRANT_CONSTANTS_FILE   = "/setup/config/constants.sh"

# PostgreSQL DB
$PG_VERSION="9.5"
$PG_LOG_DIR="/var/lib/postgresql/9.5/main/pg_log"
$POSTGRES_HOST             = "localhost"
$POSTGRES_NAME             = "mydb"
$POSTGRES_USER             = "myuser"
$POSTGRES_PASS             = "mypass"
$POSTGRES_PORT_G           = 5432
$POSTGRES_PORT_H           = 15432

# Site 1 (The Nginx config file must match this)
$SITE1_PORT_G              = 90
$SITE1_PORT_H              = 90

Vagrant.configure(2) do |config|

  # Base Box
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_url = "https://atlas.hashicorp.com/ubuntu/boxes/trusty64"
  config.vm.host_name = "vagrant-postgres-nginx" 

  # Port Forwarding
  config.vm.network :forwarded_port, guest: $POSTGRES_PORT_G, host: $POSTGRES_PORT_H # PostgreSQL
  config.vm.network :forwarded_port, guest: $SITE1_PORT_G, host: $SITE1_PORT_H # Site1

  # Synced Folder
  config.vm.synced_folder "./setup", "/setup", create: true
  config.vm.synced_folder "./tools", "/tools", create: true
  config.vm.synced_folder "./www", "/www", create: true, group: "www-data", owner: "www-data"
  config.vm.synced_folder "./dbdump", "/dbdump", create: true
  config.vm.synced_folder "./mylogs", "/mylogs", create: true

  # Provision
  config.vm.provision :shell do |s|
    s.inline = generate_constants_file();
  end
  config.vm.provision :shell, path: "./setup/provision-all.sh"

end

def generate_constants_file()
    $shScript = <<-eos
cat > #{$VAGRANT_CONSTANTS_FILE} << EndOfScript
#!/bin/sh -e

# Vagrant
export VAGRANT_CONSTANTS_FILE=#{$VAGRANT_CONSTANTS_FILE}

# DB
export POSTGRES_HOST=#{$POSTGRES_HOST}
export POSTGRES_NAME=#{$POSTGRES_NAME}
export POSTGRES_USER=#{$POSTGRES_USER}
export POSTGRES_PASS=#{$POSTGRES_PASS}
export POSTGRES_PORT_G=#{$POSTGRES_PORT_G}
export POSTGRES_PORT_H=#{$POSTGRES_PORT_H}

# PostgreSQL
export PG_VERSION=#{$PG_VERSION}
export PG_LOG_DIR=#{$PG_LOG_DIR}

EndOfScript
    eos
    return $shScript
  end
