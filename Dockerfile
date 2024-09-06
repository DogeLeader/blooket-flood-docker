# Base image
FROM debian:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    git \
    npm \
    nodejs \
    build-essential \
    cmake \
    clang \
    gcc \
    g++ \
    zlib1g-dev \
    libuv1-dev \
    libjson-c-dev \
    libwebsockets-dev \
    sudo \
    curl \
    wget \
    net-tools \
    vim \
    openssh-client \
    locales \
    bash-completion \
    iputils-ping \
    htop \
    gnupg2 \
    tmux \
    screen \
    zsh \
    && apt-get clean

# Symlink nodejs to node (in case the system installs as nodejs)
RUN ln -s /usr/bin/nodejs /usr/bin/node || true

# Download and install ttyd from source for better compatibility
RUN git clone https://github.com/tsl0922/ttyd.git /ttyd-src && \
    cd /ttyd-src && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install

# Clone the BlooketFlooder repository
RUN git clone https://github.com/VillainsRule/BlooketFlooder.git /BlooketFlood

# Set working directory to BlooketFlood
WORKDIR /BlooketFlood

# Install BlooketFlooder dependencies
RUN npm install && npm i chalk

# Ensure ttyd works with a login shell
RUN echo "export TERM=xterm-256color" >> ~/.bashrc

# Expose the port for ttyd
EXPOSE 10000

# Start ttyd with correct bash shell, ensure interactive input
CMD ["ttyd", "-p", "10000", "-t", "disableLeaveAlert=true", "bash", "-i", "-l"]
