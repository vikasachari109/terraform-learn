./script.sh start
---
#!/bin/bash

RESOURCE_GROUP="myResourceGroup"
VM_NAME="myLinuxVM"

if [ "$1" == "start" ]; then
    echo "Starting VM $VM_NAME..."
    az vm start --resource-group $RESOURCE_GROUP --name $VM_NAME
elif [ "$1" == "stop" ]; then
    echo "Stopping VM $VM_NAME..."
    az vm stop --resource-group $RESOURCE_GROUP --name $VM_NAME
else
    echo "Usage: $0 {start|stop}"
fi

---
./script.sh start
---

#!/bin/bash
echo "Adding MyApp to crontab for auto-start..."

# Add startup command to crontab
(crontab -l 2>/dev/null; echo "@reboot /usr/bin/nginx") | crontab -

echo "MyApp will now start automatically after reboot."

---

crontab -e

@reboot /bin/bash <script-path>/script.sh

script.sh
{
sudo systemctl daemon-reload
sudo systemctl enable myscript.service
sudo systemctl start myscript.service
sudo systemctl status myscript.service
}

---
#!/bin/bash

# Set threshold (change as needed)
THRESHOLD=80

# Disk to monitor (use / for root or modify as needed)
DISK="/"

# Email for alerts (configure this)
ALERT_EMAIL="admin@example.com"

# Get current disk usage percentage (only the numeric part)
USAGE=$(df -h "$DISK" | awk 'NR==2 {print $5}' | sed 's/%//')

# Get the hostname
HOSTNAME=$(hostname)

# Check if usage exceeds threshold
if [ "$USAGE" -ge "$THRESHOLD" ]; then
    MESSAGE="Warning: Disk usage on $HOSTNAME ($DISK) is at ${USAGE}%."
    
    # Log the warning
    echo "$(date) - $MESSAGE" >> /var/log/disk_usage.log

    # Send an email alert (if configured)
    echo "$MESSAGE" | mail -s "Disk Space Alert on $HOSTNAME" $ALERT_EMAIL
fi


crontab -e
*/30 * * * * /bin/bash /path/to/check_disk_usage.sh

---
-ge // greater than
-eq // equal
-ls // less than

