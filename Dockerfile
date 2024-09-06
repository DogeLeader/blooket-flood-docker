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
    net-tools  \
    vim \
    openssh-client \
    locales \
    bash-completion \
    iputils-ping \
    htop \
    gnupg2 \
    tmux \
    screen \
    zsh # buildkit \
    && apt-get clean
RUN wget https://github.com/tsl0922/ttyd/releases/download/1.6.3/ttyd.x86_64 && chmod +x ttyd.x86_64 && mv ttyd.x86_64 /usr/local/bin/ttyd # buildkit

# Clone the BlooketFlooder repository
RUN git clone https://github.com/VillainsRule/BlooketFlooder.git /BlooketFlood

# Set the working directory to BlookFlood
WORKDIR /BlooketFlood

# Install BlooketFlooder dependencies
RUN npm install && npm i chalk

# Expose the port for ttyd
EXPOSE 7681

RUN cd BlooketFlood
# Start ttyd with a bash shell and run the BlooketFlooder
CMD ["ttyd", "-p", "7681", "bash", "node", "."]
