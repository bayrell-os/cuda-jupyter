#!/bin/bash

SCRIPT=$(readlink -f $0)
SCRIPT_PATH=`dirname $SCRIPT`
BASE_PATH=`dirname $SCRIPT_PATH`

RETVAL=0
IMAGE="jupyter-cuda"
VERSION=3.4.8
SUBVERSION=1
TAG=`date '+%Y%m%d_%H%M%S'`

if [ "$APT_MIRROR" = "" ]; then
	APT_MIRROR=""
fi

case "$1" in
	
	test-amd64)
		export DOCKER_DEFAULT_PLATFORM=linux/amd64
		docker build ./ -t bayrell/$IMAGE:$VERSION-$SUBVERSION-$TAG-amd64 \
			--file Dockerfile --build-arg ARCH=amd64 --build-arg APT_MIRROR=$APT_MIRROR
	;;
	
	amd64)
		export DOCKER_DEFAULT_PLATFORM=linux/amd64
		docker build ./ -t bayrell/$IMAGE:$VERSION-$SUBVERSION-amd64 \
			--file Dockerfile --build-arg ARCH=amd64 --build-arg APT_MIRROR=$APT_MIRROR
	;;
	
	all)
		$0 amd64
		docker push bayrell/$IMAGE:$VERSION-$SUBVERSION-amd64
	;;
	
	*)
		echo "Usage: $0 {amd64|test-amd64|all}"
		RETVAL=1

esac

exit $RETVAL
