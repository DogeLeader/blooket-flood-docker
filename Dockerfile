FROM debian:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    npm \
    neofetch \
    git \
    && apt-get clean

# Clone the BlooketFlooder repository
RUN git clone https://github.com/VillainsRule/BlooketFlooder.git /BlookFlood

# Set the working directory
WORKDIR /BlookFlood

# Install dependencies
RUN npm install && npm install chalk express body-parser

# Copy the web server code
COPY server.cjs .

# Expose the port for the web server
EXPOSE 3000

# Start the web server
CMD ["node", "server.cjs"]