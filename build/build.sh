#!/bin/bash
if [ "$1" != "" ]
then
	if [ ! -f ~/.ssh/id_rsa.pub ]
    then
        ssh-keygen -t rsa  -f ~/.ssh/id_rsa -N `openssl rand -base64 8`
    fi

        cat ~/.ssh/id_rsa.pub > ./authorized_keys
fi


if [ $1 = "go1.15" ]
then
	# mv ./authorized_keys ./go1.15/
	docker build -f `pwd`/go1.15/Dockerfile -t workspace-go1.15 .
elif [ $1 = "go1.12" ]
then
	# mv ./authorized_keys ./go1.12/
	docker build -f `pwd`/go1.12/Dockerfile -t workspace-go1.12 .
else 
	echo "Please enter go1.15 or  go1.12"
fi
