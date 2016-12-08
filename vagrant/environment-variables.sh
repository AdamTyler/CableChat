#!/usr/bin/env bash
export RUBY_VERSION=2.3.1
export RUBY_INSTALL_VERSION=0.6.0
export CHRUBY_VERSION=0.3.9
export RAILS_ENV=development
test -f /usr/local/share/chruby/chruby.sh && source /usr/local/share/chruby/chruby.sh > /dev/null 2>&1
test -f /usr/local/share/chruby/auto.sh && source /usr/local/share/chruby/auto.sh > /dev/null 2>&1
