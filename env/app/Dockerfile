FROM launcher.gcr.io/google/debian9:latest

# Build arguments
ARG UID=${USER_ID}
ARG GID=${GROUP_ID}
ARG USR=${USERNAME}
ARG HOMEDIR=${HOMEDIR}
ARG WEBROOT=${WEBROOT}
ARG NVM_DIR=${NVM_DIR}

# Add the www user
RUN groupadd -g ${GID} ${USR} && \
    useradd -u ${UID} -g ${GID} -s /bin/bash -m ${USR} && \
    mkdir -p ${HOMEDIR}

# Add required packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    git \
    gnupg2 \
    inotify-tools \
    iproute2 \
    lsb-release \
    mysql-client \
    patch \
    ssh-client \
    ssmtp \
    unzip \
    wget \
    vim \
    tzdata \
    procps \
    cron

# Configure build
ENV DEBIAN_FRONTEND noninteractive
RUN rm -f /etc/localtime || true
RUN ln -s /usr/share/zoneinfo/Europe/London /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# set work directory
# WORKDIR $WEBROOT

# Install NPM & Node.Js
ENV NODE_VERSION=14.17.5
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
RUN . "${NVM_DIR}/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "${NVM_DIR}/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "${NVM_DIR}/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="${HOMEDIR}/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version

# Setup and add default CRON tasks
# ADD ./config/cron /etc/cron.d
# RUN chmod 0644 -R /etc/cron.d/

# Runtime scripts
ADD ./scripts/start.sh /usr/local/bin/
RUN chmod +x -R /usr/local/bin/start.sh

# Run start-up scripts
# NOTE: must place scripts in '/usr/local/bin' and append CMD with '; sleep infinity' to stop container shutting down
CMD /usr/local/bin/start.sh ; sleep infinity

EXPOSE 3000

