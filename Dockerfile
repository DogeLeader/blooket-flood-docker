FROM debian:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    git \
    npm \
    build-essential \
    cmake \
    clang \
    gcc \
    g++ \
    zlib1g-dev \
    libuv1-dev \
    libjson-c-dev \
    libwebsockets-dev \
    && apt-get clean
RUN /bin/sh -c wget https://github.com/tsl0922/ttyd/releases/download/1.6.3/ttyd.x86_64 && chmod +x ttyd.x86_64 && mv ttyd.x86_64 /usr/local/bin/ttyd # buildkit

# Clone the BlooketFlooder repository
RUN git clone https://github.com/VillainsRule/BlooketFlooder.git /BlookFlood

# Set the working directory to BlookFlood
WORKDIR /BlookFlood

# Install BlooketFlooder dependencies
RUN npm install

# Expose the port for ttyd
EXPOSE 7681

# Start ttyd with a bash shell and run the BlooketFlooder
CMD ["ttyd", "-p", "7681", "bash", "node ."]
