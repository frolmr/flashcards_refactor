#!/bin/bash

echo "Update and add epel repo"
sudo yum update
sudo yum install -y epel-release

echo "Install postgres with dependencies"
sudo yum install -y postgresql-server postgresql-contrib postgresql-devel

echo "Init postgres"
sudo postgresql-setup initdb

echo "Start postgres service"
sudo systemctl start postgresql
sudo systemctl enable postgresql

echo "Change default user password"
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'gfhjkm';"

echo "Postrgres config"
sudo sed -i -e 's/peer/md5/g;s/ident/md5/g' /var/lib/pgsql/data/pg_hba.conf
sudo systemctl restart postgresql

echo "Install dependencies for rbenv"
sudo yum install -y git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel nodejs

echo "Installing rbenv"
cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile

source ~/.bash_profile

echo "Installing ruby"
rbenv install 2.3.0
rbenv global 2.3.0

echo "Installing bundler"
gem install bundler

echo "Installing gems"
cd /home/vagrant/flashcards/
bundle install

echo "Creating databases and migrations"
rake db:create
rake db:migrate

echo "Start server"
rails s -b 0.0.0.0
