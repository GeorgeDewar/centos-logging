#!/bin/bash

# Install nginx
yum install -y nginx

# Install Kibana
cd /tmp
wget https://download.elasticsearch.org/kibana/kibana/kibana-3.0.0.tar.gz -O kibana.tar.gz
tar -xzf kibana.tar.gz
mv kibana /usr/share/kibana3

# Set logstash dashboard as the default
mv /usr/share/kibana/app/dashboards/logstash.json /usr/share/kibana/app/dashboards/default.json

