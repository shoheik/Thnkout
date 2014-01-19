## Install ansible on Sakura VPS (case of ansible distritution server)

    rpm -ivh http://ftp.riken.jp/Linux/fedora/epel/6/i386/epel-release-6-8.noarch.rpm
    yum install ansible -y

## on mac
    
    $ brew install ansible

## run playbook
    $ ansible-playbook -i ./hosts adduser.yml



