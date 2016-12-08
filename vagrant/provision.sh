#!/usr/bin/env bash

source /vagrant/vagrant/environment-variables.sh

log_title() {
	echo -e "\n\n\n"
	echo ==============================================================================
	echo "$@"...
	echo -e "\n"
}

run() {
	/bin/bash /vagrant/vagrant/${1}.sh
}

bail_if_error()
{
  local err=$1
  if [[ $err -ne 0 ]];then
    echo "Erred running provisioning command! ${2}"
    exit 1
  fi
}
log_title "Starting with fixing timezones. "
echo 'Etc/UTC' | sudo tee /etc/timezone; sudo dpkg-reconfigure --frontend noninteractive tzdata

log_title "I am updating and installing system software"
run system
bail_if_error $? "System"

log_title "I am preparing the database"
run database
bail_if_error $? "Database"

log_title "I am updating the environment"
source /vagrant/vagrant/environment-variables.sh

cat > /home/vagrant/.vagrant.env <<__END__
export RAILS_ENV=development
source /usr/local/share/chruby/chruby.sh > /dev/null 2>&1
source /usr/local/share/chruby/auto.sh > /dev/null 2>&1
chruby ${RUBY_VERSION} > /dev/null 2>&1
alias opendb='mysql -u root -predvsblue RedVsBlue'
cd /vagrant
__END__

# for non-login
echo '. ~/.vagrant.env' >> /home/vagrant/.bashrc
# for login
echo '. ~/.vagrant.env' >> /home/vagrant/.bash_profile

log_title "I am installing ruby"
sudo su -  vagrant -l -c /vagrant/vagrant/ruby.sh
bail_if_error $? "Ruby"

log_title "I am configuring rails"
sudo su -  vagrant -l -c /vagrant/vagrant/rails.sh
bail_if_error $? "Rails"

sudo service mysql restart
sudo ntpdate pool.ntp.org
sudo service redis-server restart

cd /vagrant

log_title "Running built-in rails server as a background job"
spring stop
sudo su -  vagrant -l -c "./bin/web start_development"

log_title "Running sidekiq background jobs"
sudo su -  vagrant -l -c "./bin/background_jobs start"
if [[ $? -ne 0 ]];then
  echo "Unable to start sidekiq!!"
fi

log_title "Finished"
echo "I am done! check it out: http://localhost:3003"
echo "On OSX use Command + Click to open the above URL."
echo "I am designed to respond to any domain you point at me."
echo "use \"vagrant ssh\" to login to vagrant, and then type \"RAILS_ENV=test rake spec\" to launch testing."