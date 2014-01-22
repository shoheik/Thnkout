## Install ansible on Sakura VPS (case of ansible distritution server)

    rpm -ivh http://ftp.riken.jp/Linux/fedora/epel/6/i386/epel-release-6-8.noarch.rpm
    yum install ansible -y

## on mac
    
    $ brew install ansible

## run playbook
    $ ansible-playbook -i ./hosts adduser.yml

## yo needs to be run manually as it's prompted,,,

    $ cd Thnkout/front
    $ yo angular

    $ cd Thnkout/front
    $ grunt server # to make sure it can be up
    $ grunt build

    $ cd ../back
    $ mysql -u thnkout -D thnkout_test -p < db/schema.sql


