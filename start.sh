#!/bin/bash

if [ $1 = "start" ]
then

cat>>.bashrc<<EOF
export GOROOT=/usr/local/lib/go
export GOPATH=/root/go
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH
export GO111MODULE=on
export GOPROXY=https://goproxy.io
EOF
	

	echo "Setup ..."
	/etc/init.d/ssh restart

	echo "Success"
	echo ""
	echo "-------------------------------------"

	tail -f /dev/null

elif [ $1 = "bash" ]
then
	/bin/bash
else
	echo "not understand"
fi

