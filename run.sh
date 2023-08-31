#!/bin/bash

if [ -x "$(command -v docker)" ]; then
    echo "Docker is already installed."
else
    echo "Docker is not installed. Installing..."
    curl -fsSL https://get.docker.com | sh
fi

mkdir -p /var/lib/xui_watcher && touch /var/lib/xui_watcher/config.json
#docker build -t hadish10/xui_watcher .
docker pull hadish10/xui_watcher
docker run -it -v /var/lib/xui_watcher/config.json:/config.json --entrypoint "node" hadish10/xui_watcher config1.js
docker run -d -v /var/lib/xui_watcher/config.json:/config.json --name xui_watcher --restart always hadish10/xui_watcher
echo 'alias xui_watcher_config1='"'"'docker run -it -v /var/lib/xui_watcher/config.json:/config.json --entrypoint "node" hadish10/xui_watcher config1.js'"'" >> ~/.bashrc
echo 'alias xui_watcher_config2='"'"'docker run -it -v /var/lib/xui_watcher/config.json:/config.json --entrypoint "node" hadish10/xui_watcher config2.js'"'" >> ~/.bashrc
. ~/.bashrc

#docker stop xui_watcher && docker rm xui_watcher