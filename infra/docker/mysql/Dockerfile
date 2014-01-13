FROM centos

RUN yum -y update
RUN yum -y install mysql-server mysql mysql-devel

# ADD mysql/my.cnf /etc/my.cnf

# mysqlによる書き込みを永続化
VOLUME ["/var/lib/mysql"]        

#This file is needed in /etc/init.d/mysqld
RUN touch /etc/sysconfig/network 

ADD start.sh /start.sh
RUN chmod 700 start.sh
RUN /start.sh

# Open port
EXPOSE  3306

