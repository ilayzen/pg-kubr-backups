#!/bin/bash

# Configuration
CONTAINERS=("postgres-db-6d596c69bb-jnlrf")
BACKUP_DIR="/var/lib/postgres/backups"

# Get the current date and time for the backup filename
TIMESTAMP=$(date +'%d-%m-%Y_%H_%M_%S')

# Loop through the list of containers and perform backups
for container_name in "${CONTAINERS[@]}"; do
    # Run the pg_dumpall command to create a dump of all databases in the container
    kubectl exec -t "$container_name" -- pg_dumpall -U yaDeadInside > "$BACKUP_DIR/${container_name}_${TIMESTAMP}.sql"
    if [ $? -eq 0 ]; then
        echo "Backup of container '$container_name' completed successfully."
    else
        echo "Backup of container '$container_name' failed."
    fi
done
