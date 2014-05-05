#!/bin/bash
 
yum install -y java-1.7.0-openjdk

rpm --import http://packages.elasticsearch.org/GPG-KEY-elasticsearch

cat > /etc/yum.repos.d/LogStash-1.4 <<- EOF
[logstash-1.4]
name=logstash repository for 1.4.x packages
baseurl=http://packages.elasticsearch.org/logstash/1.4/centos
gpgcheck=1
gpgkey=http://packages.elasticsearch.org/GPG-KEY-elasticsearch
enabled=1
EOF

