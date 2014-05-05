#!/bin/bash
 
yum install -y java-1.7.0-openjdk
 
cat > /etc/yum.repos.d/ElasticSearch-1.0.repo <<- EOF
[elasticsearch-1.0]
name=Elasticsearch repository for 1.0.x packages
baseurl=http://packages.elasticsearch.org/elasticsearch/1.0/centos
gpgcheck=1
gpgkey=http://packages.elasticsearch.org/GPG-KEY-elasticsearch
enabled=1
EOF
 
yum install -y elasticsearch
/sbin/chkconfig --add elasticsearch
