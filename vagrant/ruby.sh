#!/usr/bin/env bash
source $(dirname $0)/environment-variables.sh

source_env()
{
    source $(dirname $0)/environment-variables.sh
}

install_ruby_install()
{
    # Install ruby-install
    cd ~
    wget -O ruby-install-${RUBY_INSTALL_VERSION}.tar.gz https://github.com/postmodern/ruby-install/archive/v${RUBY_INSTALL_VERSION}.tar.gz
    tar -xzvf ruby-install-${RUBY_INSTALL_VERSION}.tar.gz
    cd ruby-install-${RUBY_INSTALL_VERSION}/
    sudo make install
    echo "Done installing ruby version ${RUBY_VERSION}"
    cd /vagrant
}

# Install chruby:
install_chruby()
{
    cd ~
    wget -O chruby-${CHRUBY_VERSION}.tar.gz https://github.com/postmodern/chruby/archive/v${CHRUBY_VERSION}.tar.gz
    tar -xzvf chruby-${CHRUBY_VERSION}.tar.gz
    cd chruby-${CHRUBY_VERSION}/
    sudo make install
    echo "Done installing chruby version ${CHRUBY_VERSION}"
    cd /vagrant
}

update_gemrc()
{
cat > /home/vagrant/.gemrc <<END
install: --no-document
update: --no-document
END
}

install_ruby()
{
    # Install RUBY
    sudo ruby-install ruby ${RUBY_VERSION}
}

# dont download gem docs
update_gemrc

(chruby > /dev/null 2>&1) || install_chruby

# Check for ruby-install
ruby-install > /dev/null 2>&1 || install_ruby_install


source_env
chruby ${RUBY_VERSION} || install_ruby
# Assuming the install_ruby call worked, re-source and set the version
source_env
chruby ${RUBY_VERSION}

gem install bundler

