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

# Set environment variable for terminal type
ENV TERM=xterm-256color

# Download and install ttyd from a specific version for compatibility
RUN git clone --branch 1.6.3 https://github.com/tsl0922/ttyd.git /ttyd-src && \
    cd /ttyd-src && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install

# Clone the BlooketFlooder repository
RUN git clone https://github.com/VillainsRule/BlooketFlooder.git /BlooketFlood

# Set working directory to BlooketFlooder
WORKDIR /BlooketFlood

# Install BlooketFlooder dependencies
RUN npm install && npm i chalk

# Expose the port for ttyd
EXPOSE 7681

# Run BlooketFlooder with ttyd on startup
CMD ["bash", "-c", "ttyd -p 7681 bash -c 'node .'"]
