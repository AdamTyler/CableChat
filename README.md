## Attribution

Source code for the [Create a Chat App with Rails 5, ActionCable, and Devise](https://www.sitepoint.com/create-a-chat-app-with-rails-5-actioncable-and-devise/) article on
SitePoint,
created by Ilya Bodrov ([bodrovis.tech](http://bodrovis.tech)).

## Modifications

- Added a basic Vagrant setup
- Set default port to 3005 from 3000
- Set Vagrant IP to 10.11.12.16 from localhost or 127.0.0.1

## Setup Instructions

- Ensure you have VirtualBox and Vagrant installed
- Clone this repository locally
- Start Vagrant from within the repository directory

```
vagrant up --provision
```

- Login and start the web service

```
ssh vagrant
cd /vagrant
bin/rails s -b 10.11.12.16 -p 3005
```
- Access the web server via http://10.11.12.16:3005
- Register a new user and login
- Create a new chat room
- Enter room and add messages to verify everything is working
