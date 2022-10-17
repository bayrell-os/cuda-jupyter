ARG ARCH=amd64
FROM nvidia/cuda:11.7.1-base-ubuntu22.04

ARG ARCH
ENV ARCH=${ARCH}

RUN cd ~; \
	export DEBIAN_FRONTEND='noninteractive'; \
	apt-get update; \
	apt-get install -y --no-install-recommends apt-utils locales ca-certificates; \
	apt-get clean all; \
	ln -snf /usr/share/zoneinfo/Asia/Almaty /etc/localtime; \
	echo "Asia/Almaty" > /etc/timezone; \
	locale-gen en_US en_US.UTF-8 ru_RU.UTF-8; \
	update-locale LANG=en_US.utf8 LANGUAGE=en_US:en; \
	echo "LANG="en_US.utf8" \n\
LANGUAGE="en_US:en" \n\
export LANG \n\
export LANGUAGE\n" >> /etc/bash.bashrc; \
	echo 'Ok'

RUN cd ~; \
	apt-get install -y --no-install-recommends tzdata debconf-utils mc less nano wget pv zip \
		unzip supervisor net-tools iputils-ping sudo curl gnupg; \
	apt-get clean all; \
	echo 'Ok'

RUN cd ~; \
	export DEBIAN_FRONTEND='noninteractive'; \
	wget https://openresty.org/package/pubkey.gpg; \
    gpg --dearmor -o /usr/share/keyrings/openresty.gpg pubkey.gpg; \
    rm pubkey.gpg; \
	if [ "$ARCH" = "amd64" ]; then echo "deb [signed-by=/usr/share/keyrings/openresty.gpg] http://openresty.org/package/ubuntu jammy main" > /etc/apt/sources.list.d/openresty.list; fi; \
	if [ "$ARCH" = "arm64v8" ]; then echo "deb [signed-by=/usr/share/keyrings/openresty.gpg] http://openresty.org/package/arm64/ubuntu jammy main" > /etc/apt/sources.list.d/openresty.list; fi; \
	apt-get update; \
	apt-get install -y --no-install-recommends python3-pip python3-venv python3-dev \
		openresty lua-cjson lua-md5 lua-curl luarocks jq git ca-certificates \
		make build-essential docker.io pandoc; \
	luarocks install lua-resty-jwt; \
	apt-get clean all; \
	sed -i "s|www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin|www-data:x:33:33:www-data:/data/home:/bin/bash|g" /etc/passwd; \
	ln -sf /dev/stdout /usr/local/openresty/nginx/logs/access.log; \
	ln -sf /dev/stderr /usr/local/openresty/nginx/logs/error.log; \
	echo 'Ok'

RUN cd ~; \
    pip3 install jupyterlab==3.4.8; \
    echo 'Ok'

COPY files /
RUN cd ~; \
	chmod +x /root/*.sh; \
	echo 'Ok'

CMD ["/root/run.sh"]