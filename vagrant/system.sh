#!/usr/bin/env bash

swap_done="/.swap_done"
if [[ ! -f "${swap_done}" ]] ; then
    sudo dd if=/dev/zero of=/swapfile bs=1024 count=2097152
    sudo chown root:root /swapfile
    sudo chmod 0600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
fi
touch ${swap_done}

updated="/.updated"
test -f ${updated} || sudo apt-get update -y
touch ${updated}

sudo apt-get install -y \
git-core \
curl \
zlib1g-dev \
build-essential \
libssl-dev \
libreadline-dev \
libyaml-dev \
libsqlite3-dev \
sqlite3 \
libxml2-dev \
libxslt1-dev \
libcurl4-openssl-dev \
nodejs \
python-software-properties \
libffi-dev \
build-essential \
libmysqlclient-dev \
redis-server \
redis-tools \
git-all


chmod 2775 /usr/local/bin
chown :vagrant /usr/local/bin
chmod 2775 /opt
chown :vagrant /opt
chmod 2775 /usr/local/share
chown :vagrant /usr/local/share
