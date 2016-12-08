#!/usr/bin/env bash
source $(dirname $0)/environment-variables.sh

chruby ${RUBY_VERSION}

# do the bundling
cd /vagrant

find config/*.yml.example | while read line
do
    newfile=$(echo $line  | sed -e 's/.example//')
    echo "Copying ${newfile}"
    if [[ ! -f "${newfile}" ]] ; then
        cp ${line} ${newfile}
    fi
done

bundle install
rake db:create db:migrate
