# Bash And Cron Snippets

These are small automation examples that pair well with Terraform-based environments.

## Start Or Stop A VM

```bash
#!/bin/bash

RESOURCE_GROUP="myResourceGroup"
VM_NAME="myLinuxVM"

if [ "$1" = "start" ]; then
  echo "Starting VM $VM_NAME..."
  az vm start --resource-group "$RESOURCE_GROUP" --name "$VM_NAME"
elif [ "$1" = "stop" ]; then
  echo "Stopping VM $VM_NAME..."
  az vm stop --resource-group "$RESOURCE_GROUP" --name "$VM_NAME"
else
  echo "Usage: $0 {start|stop}"
fi
```

Run it with:

```bash
./script.sh start
./script.sh stop
```

## Start A Service On Reboot

Add this with `crontab -e`:

```cron
@reboot /usr/bin/nginx
```

If you want to trigger a custom script on reboot:

```cron
@reboot /bin/bash /path/to/script.sh
```

## Example Service Management Script

```bash
#!/bin/bash
sudo systemctl daemon-reload
sudo systemctl enable myscript.service
sudo systemctl start myscript.service
sudo systemctl status myscript.service
```

## Disk Usage Alert Script

```bash
#!/bin/bash

THRESHOLD=80
DISK="/"
ALERT_EMAIL="admin@example.com"

USAGE=$(df -h "$DISK" | awk 'NR==2 {print $5}' | sed 's/%//')
HOSTNAME=$(hostname)

if [ "$USAGE" -ge "$THRESHOLD" ]; then
  MESSAGE="Warning: Disk usage on $HOSTNAME ($DISK) is at ${USAGE}%."
  echo "$(date) - $MESSAGE" >> /var/log/disk_usage.log
  echo "$MESSAGE" | mail -s "Disk Space Alert on $HOSTNAME" "$ALERT_EMAIL"
fi
```

Run every 30 minutes:

```cron
*/30 * * * * /bin/bash /path/to/check_disk_usage.sh
```

## Common Bash Test Operators

- `-ge`: greater than or equal
- `-eq`: equal
- `-lt`: less than
