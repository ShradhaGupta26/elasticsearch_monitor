#!/bin/bash

wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.1.2-x86_64.rpm
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.1.2-x86_64.rpm.sha512
shasum -a 512 -c elasticsearch-8.1.2-x86_64.rpm.sha512
sudo rpm --install elasticsearch-8.1.2-x86_64.rpm

sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service
private_ip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "http.port: 9200"  >> /etc/elasticsearch/elasticsearch.yml
echo "network.host: $private_ip"  >> /etc/elasticsearch/elasticsearch.yml
sed -i '/xpack.security.enabled: true/c\xpack.security.enabled: false' /etc/elasticsearch/elasticsearch.yml
sed -i '/xpack.security.enrollment.enabled: true/c\xpack.security.enrollment.enabled: false' /etc/elasticsearch/elasticsearch.yml
sudo systemctl restart elasticsearch.service
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch_exporter

# Install ElasticSearch exporter
wget https://github.com/justwatchcom/elasticsearch_exporter/releases/download/v1.1.0rc1/elasticsearch_exporter-1.1.0rc1.linux-amd64.tar.gz
tar -xvf elasticsearch_exporter-1.1.0rc1.linux-amd64.tar.gz
cd elasticsearch_exporter-1.1.0rc1.linux-amd64/
sudo cp elasticsearch_exporter /usr/local/bin/

# Create a systemd service file for the exporter
cat << EOF | sudo tee /etc/systemd/system/elasticsearch_exporter.service
[Unit]
Description=ElasticSearch exporter
Wants=network-online.target
After=network-online.target

[Service]
User=root
Group=root
ExecStart=/usr/local/bin/elasticsearch_exporter

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start the exporter
sudo systemctl daemon-reload
sudo systemctl start elasticsearch_exporter
sudo systemctl enable elasticsearch_exporter

