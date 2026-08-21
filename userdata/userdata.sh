#!/bin/bash
set -e

# Update system
dnf update -y

# Install Apache
dnf install -y httpd

# Install Amazon EFS utilities
dnf install -y amazon-efs-utils

# Install CloudWatch Agent
dnf install -y amazon-cloudwatch-agent

# Create mount point
mkdir -p /mnt/efs

# Mount EFS
mount -t efs ${efs_dns_name}:/ /mnt/efs

# Persist mount after reboot
echo "${efs_dns_name}:/ /mnt/efs efs defaults,_netdev 0 0" >> /etc/fstab

# Create a simple web page
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
<title>Terraform Image Gallery</title>
</head>
<body style="font-family: Arial; text-align:center; margin-top:50px;">
<h1>Terraform AWS Image Gallery</h1>
<p>Deployment Successful!</p>
<p>Hostname: $(hostname)</p>
<p>Environment: ${environment}</p>
</body>
</html>
EOF

# Configure persistent system log export
mkdir -p /var/log/journal

cat <<'EOF' > /etc/systemd/system/image-gallery-journal.service
[Unit]
Description=Export systemd journal for CloudWatch Logs
After=systemd-journald.service
Requires=systemd-journald.service

[Service]
Type=simple
ExecStart=/bin/bash -c '/usr/bin/journalctl -f -n 0 -o short-iso > /var/log/image-gallery-system.log'
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable image-gallery-journal.service
systemctl start image-gallery-journal.service

# Configure CloudWatch Agent
mkdir -p /opt/aws/amazon-cloudwatch-agent/etc

cat <<'EOF' > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
{
  "agent": {
    "metrics_collection_interval": 60,
    "run_as_user": "root"
  },
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/httpd/access_log",
            "log_group_name": "/image-gallery/apache/access",
            "log_stream_name": "{instance_id}",
            "retention_in_days": 30
          },
          {
            "file_path": "/var/log/httpd/error_log",
            "log_group_name": "/image-gallery/apache/error",
            "log_stream_name": "{instance_id}",
            "retention_in_days": 30
          },
          {
            "file_path": "/var/log/image-gallery-system.log",
            "log_group_name": "/image-gallery/system",
            "log_stream_name": "{instance_id}",
            "retention_in_days": 30
          }
        ]
      }
    }
  }
}
EOF

# Enable and start Apache
systemctl enable httpd
systemctl start httpd

# Start CloudWatch Agent
systemctl enable amazon-cloudwatch-agent
systemctl start amazon-cloudwatch-agent