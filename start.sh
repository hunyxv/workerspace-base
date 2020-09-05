#!/bin/bash

if [ $1 = "start" ]
then
	echo "Setup ..."
	/etc/init.d/ssh restart

	ssh-keygen -t rsa  -f /root/.ssh/id_rsa -N `openssl rand -base64 8`

	echo "Success"
	echo ""
	echo "-------------------------------------"
	echo ""

	tail -f /root/.ssh/id_rsa.pub

elif [ $1 = "bash" ]
then
	/bin/bash
else
	echo "not understand"
fi
