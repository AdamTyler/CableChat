#!/usr/bin/env bash

source $(dirname $0)/environment-variables.sh

cat > ~/.vagrant.env <<__END__
export RAILS_ENV=development
source /usr/local/share/chruby/chruby.sh > /dev/null 2>&1
source /usr/local/share/chruby/auto.sh > /dev/null 2>&1
chruby ${RUBY_VERSION} > /dev/null 2>&1
alias opendb='mysql -u root -predvsblue RedVsBlue'
cd /vagrant
__END__

grep 'vagrant.env' ~/.bashrc > /dev/null 2>&1 || echo ". ~/.vagrant.env" >> ~/.bashrc
