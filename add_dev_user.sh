#!/bin/bash

# Check if three arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <dev_name> <dev_ssh> <server_name>"
    exit 1
fi

# Store arguments in variables
dev_name=$1
dev_ssh=$2
server_name=$3

# Add a new user
sudo adduser $dev_name

# Add the user to the wheel group (sudo group)
sudo usermod -aG wheel $dev_name

# Grant passwordless sudo access
echo "$dev_name ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$dev_name

# Switch to the new user and configure SSH and .bashrc
sudo su - $dev_name <<EOF

# Create .ssh directory, navigate into it, and set up SSH key
mkdir -p .ssh && cd .ssh
echo "$dev_ssh" > authorized_keys

# Set correct permissions for SSH keys and folder
chmod 600 authorized_keys
chmod 700 ~/.ssh

# Append 'sudo su - <server_name>' to .bashrc
echo "sudo su - $server_name" >> ~/.bashrc

EOF

# Return to the previous user (optional)
sudo su - $server_name
