#!/bin/bash
set -e

cd /srv/gitrepo

if [ -z $GIT_REPO ]; then
	echo "Pelase set GIT_REPO env variable"
	exit 1
fi

if [ -f $SECRET_KEY_LOCATION ]; then
	mkdir ~/.ssh
	chmod 700 ~/.ssh
	cp $SECRET_KEY_LOCATION ~/.ssh/id_rsa
	chmod 600 ~/.ssh/id_rsa
	SERVER=${GIT_REPO%:*}
	SERVER=${SERVER#*@}
	ssh-keyscan $SERVER >> ~/.ssh/known_hosts
fi

git clone $OPTIONSL_ARGS $GIT_REPO
cd `ls -d $PWD/*/`
git checkout $GIT_BRANCH

while true; do
	git pull || git reset --hard
	sleep $DELAY
done