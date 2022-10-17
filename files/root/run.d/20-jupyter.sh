
if [ ! -d /data/home/code ]; then
	mkdir -p /data/home/code
	chown www-data:www-data /data/home/code
fi

if [ ! -d /data/home/code/extensions ]; then
	mkdir -p /data/home/code/extensions
	chown www-data:www-data /data/home/code/extensions
fi

if [ ! -d /data/home/code/User ]; then
	mkdir -p /data/home/code/User
	chown www-data:www-data /data/home/code/User
fi

#if [ "$JUPYTER_ENABLE_ADMIN" = "1" ]; then
#	sed -i 's|127.0.0.1|0.0.0.0|g' /etc/supervisor.d/jupyter.ini
#fi
