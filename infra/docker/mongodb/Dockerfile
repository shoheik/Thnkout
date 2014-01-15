FROM centos

RUN yum -y update
ADD mongodb.repo /etc/yum.repos.d/mongodb.repo 
RUN yum -y install mongo-10gen mongo-10gen-server 

RUN /sbin/service mongod start
RUN /sbin/chkconfig mongod on

EXPOSE 27017

