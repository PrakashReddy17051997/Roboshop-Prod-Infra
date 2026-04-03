#!/bin/bash
# 1. Enable debugging
set -ex

# 2. CRITICAL: Set HOME and Working Directory
export HOME=/root
cd /root

# 3. Set environment variables for the installer
export AUTO_INSTALL=y
export APPROVE_INSTALL=y
export APPROVE_IP=y
export IPV6_SUPPORT=n
export PORT_CHOICE=1
export PROTOCOL_CHOICE=2
export DNS=cloudflare
export COMPRESSION_ENABLED=n
export CUSTOMIZE_ENC=n
export CLIENT=Prakash
export PASS=1

# 4. Download and Execute
curl -O https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh
chmod +x openvpn-install.sh

# Use the install command
./openvpn-install.sh install

mv /root/Prakash.ovpn /home/centos/Prakash.ovpn
chmod 644 /home/centos/Prakash.ovpn