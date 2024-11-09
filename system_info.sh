#!/bin/bash

# Set the interval in seconds 
interval=3

# Infinite loop
while true; do
    # Display the current date and time
    echo "Current date and time: $(date)"

    # Operating system information
    echo "Operating System: $(uname -o)"
    echo "Kernel Version: $(uname -r)"
    
    # CPU information
    echo "CPU: $(lscpu | grep 'Model name' | awk -F': ' '{print $2}')"
    
    # RAM information (total and used)
    ram_total=$(free -h | grep 'Mem:' | awk '{print $2}')
    ram_used=$(free -h | grep 'Mem:' | awk '{print $3}')
    echo "RAM - Total: $ram_total, Used: $ram_used"

    # Disk information (total and used)
    disk_total=$(df -h / | grep '/' | awk '{print $2}')
    disk_used=$(df -h / | grep '/' | awk '{print $3}')
    echo "Disk Space - Total: $disk_total, Used: $disk_used"
    
    # Separator line
    echo "**************************************************"
    
    # Wait for the specified interval
    sleep $interval
done
