#!/bin/bash

# Make sure wget is up-to-date, to avoid SSL errors with SANs
yum install -y wget 

# Install Kibana
cd /tmp
wget https://download.elasticsearch.org/kibana/kibana/kibana-3.0.0.tar.gz -O kibana.tar.gz
tar -xzf kibana.tar.gz
mv kibana /usr/share/kibana

# Set logstash dashboard as the default
mv -f /usr/share/kibana/app/dashboards/logstash.json /usr/share/kibana/app/dashboards/default.json

# Install and configure nginx
cat > /etc/yum.repos.d/nginx.repo <<- EOF
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/6/x86_64/
gpgcheck=0
enabled=1
EOF
yum install -y nginx httpd-tools
wget https://raw.githubusercontent.com/GeorgeDewar/centos-logging/master/kibana.site -O /etc/nginx/conf.d/kibana.conf
rm -f /etc/nginx/conf.d/default.conf

# Create an .htpasswd file (INTERACTIVE)
echo "Creating admin account for basic auth..."
htpasswd -c /etc/nginx/conf.d/kibana.htpasswd admin

# Start it up
service nginx start
