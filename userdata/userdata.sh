#!/bin/bash
set -e

# Update system
dnf update -y

# Install Apache
dnf install -y httpd

# Install Amazon EFS utilities
dnf install -y amazon-efs-utils

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

# Enable and start Apache
systemctl enable httpd
systemctl start httpd