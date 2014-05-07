#!/bin/bash

# Make sure wget is up-to-date, to avoid SSL errors with SANs
yum install -y wget 

# Install Kibana
cd /tmp
if [ ! -f "kibana-3.0.0.tar.gz" ]; then
  wget https://download.elasticsearch.org/kibana/kibana/kibana-3.0.0.tar.gz -O kibana-3.0.0.tar.gz
fi
tar -xzf kibana-3.0.0.tar.gz
mv kibana-3.0.0 /usr/share/kibana

# Set logstash dashboard as the default
mv -f /usr/share/kibana/app/dashboards/logstash.json /usr/share/kibana/app/dashboards/default.json
# Set the location of elasticsearch
sed -i "s|\s*elasticsearch:.*$|elasticsearch: window.location.protocol+\"//\"+window.location.hostname,|g" /usr/share/kibana/config.js

# Install and configure nginx
cat > /etc/yum.repos.d/nginx.repo <<- EOF
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/6/x86_64/
gpgcheck=0
enabled=1
EOF
yum install -y nginx httpd-tools
if [ ! -f "/tmp/kibana.site" ]; then
  wget https://raw.githubusercontent.com/GeorgeDewar/centos-logging/master/kibana.site -O /etc/nginx/conf.d/kibana.conf
else
  cp /tmp/kibana.site /etc/nginx/conf.d/kibana.conf
fi
rm -f /etc/nginx/conf.d/default.conf

# Create an .htpasswd file (INTERACTIVE)
echo "Creating admin account for basic auth..."
htpasswd -c /etc/nginx/conf.d/kibana.htpasswd admin

# Start it up
service nginx start
