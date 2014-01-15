

## how to get the latest git version on centos6 64bit

    rpm -i 'http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm'
    rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt
    vi /etc/yum.repos.d/rpmforge.repo # enable extra from 0 to 1
    yum update git


