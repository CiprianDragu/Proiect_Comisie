# Dockerfile.bash
FROM ubuntu:latest

# Install necessary packages to run the Bash script
RUN apt-get update && \
    apt-get install -y bash lsb-release procps

# Create and copy the Bash script into the container
COPY system_info.sh /system_info.sh

# Ensure the script has execute permissions
RUN chmod +x /system_info.sh

# Run the script as the main command
CMD ["/system_info.sh"]
