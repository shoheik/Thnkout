FROM centos

RUN yum -y update
RUN yum -y install mysql-server mysql mysql-devel

# ADD mysql/my.cnf /etc/my.cnf
ADD my.cnf /etc/my.cnf

# mysqd to /var/lib/mysql
VOLUME ["/var/lib/mysql"]        

#This file is needed in /etc/init.d/mysqld
RUN touch /etc/sysconfig/network 

# Setting tables
ADD start.sh /start.sh
RUN chmod 700 start.sh
RUN /start.sh

# Open port
EXPOSE  3306

# Start mysqld after restart
RUN /sbin/chkconfig mysqld on

