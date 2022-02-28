#!/bin/bash


# declare variables
version
ACTION=${1}

# starts nginx service
function start() {

sudo yum update -y
sudo amazon-linux-extras install nginx1.12 -y
ps ax | grep nginx | grep -v grep
sudo service nginx start
sudo chkconfig nginx on
sudo aws s3 cp s3://aud3lu-assignment-webserver/index.html /usr/share/nginx/html/index.html
}

# removes nginx server
function remove() {

sudo service nginx stop
sudo rm -f /usr/share/nginx/html/index.html
sudo remove nginx -y
}

# shows version
function showversion() {

echo "version: $version"
}

function help() {

cat << EOF
Usage: ${0} {-r|--remove|-h|--help}
OPTIONS:
-r|--remove removes nginx server
-v|--version shows version
-h|--help displays the command help

EXAMPLES:
	remove nginx server:
		$ ${0} -r

	show version:
		$ ${0} -v

	display help:
		$ ${0} -h

EOF

case "$ACTION" in
	-r|--remove)
		remove
		;;
	-v|--version)
		showversion
		;;
	-h|--help)
		help
		;;
	*)
	echo "Usage ${0} {-r|-v|-h}"
	exit 1
esac

