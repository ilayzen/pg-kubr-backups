# Use an official PostgreSQL client tools image as the base image
FROM postgres:latest

RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl -y && \
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    apt-get install -y kubectl

# Copy your backup script into the container
COPY backup.sh /usr/local/bin/backup.sh
# Make the script executable
RUN chmod +x /usr/local/bin/backup.sh

# Define an entry point to run your script
ENTRYPOINT ["/usr/local/bin/backup.sh"]
