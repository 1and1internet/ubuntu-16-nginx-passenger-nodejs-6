FROM 1and1internet/ubuntu-16-nginx-passenger
MAINTAINER brian.wilkinson@1and1.co.uk
ARG DEBIAN_FRONTEND=noninteractive
COPY src /usr/src
COPY files /
RUN \
	apt-get update -q && \
	apt-get install -y curl apt-transport-https ca-certificates && \
	curl --fail -ssL -o setup-nodejs https://deb.nodesource.com/setup_6.x && \
	bash setup-nodejs && \
	rm -f setup-nodejs && \
	apt-get install -y build-essential nodejs && \
	sed -i 's|wsgi;|node;\n        passenger_startup_file app.js;|' /etc/nginx/sites-enabled/default && \
	/usr/bin/passenger-config validate-install  --auto --no-colors && \
	apt-get -y clean && \
	rm -rf /var/lib/apt/lists/*
