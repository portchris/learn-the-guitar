FROM jwilder/nginx-proxy:alpine

# Build arguments
ARG UID=${USER_ID}
ARG GID=${GROUP_ID}
ARG USR=${USERNAME}
ARG PORT=${VIRTUAL_PORT}

# Add required packages
RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
		shadow \
        ca-certificates \
        curl \
        inotify-tools \
		vim \
		tzdata \
		certbot

# Configure build
# ENV DEBIAN_FRONTEND noninteractive
RUN rm -f /etc/localtime || true
RUN cp /usr/share/zoneinfo/Europe/London /etc/localtime && \
    date

# Default nginx homepage
ADD ./default /usr/share/nginx/html

# Add config and scripts
ADD ./webserver/ /etc/nginx
ADD ./scripts /scripts
RUN chmod +x -R /scripts

# Add environment variables
ADD ./.env /etc/nginx

# Copy localhost self-signed certificates
ADD ./certs /etc/nginx/certs

EXPOSE 80 443 ${PORT}

# Execute Nginx config using environment variables to start all services
CMD ["bash", "/scripts/start.sh"]