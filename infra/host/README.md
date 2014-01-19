
### add ssh rsa pubkey to remote

    # on mac
    $ brew install ssh-copy-id
    $ ssh-copy-id -i .ssh/id_rsa.pub root@thnkout.com
    $ ssh root@thnkout.com
    # vi /etc/ssh/sshd_config
    ### add this line
    PasswordAuthentication no 
    # /etc/init.d/sshd restart 
    

## how to get the latest git version on centos6 64bit

    rpm -i 'http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm'
    rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt
    vi /etc/yum.repos.d/rpmforge.repo # enable extra from 0 to 1
    yum update git

## ansible
     ansible -i hosts servers -m ping -u root

