#!/bin/bash
apt-get -y update
apt-get -y install wget gnupg2
wget -qO - http://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
echo "deb [arch=amd64] http://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list
apt-get -y update
apt-get -y install mongodb-org
