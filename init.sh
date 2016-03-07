#!/bin/bash

DIR='/usr/local/wso2emm/repository'

if [ "$(ls -A $DIR)" ]; then
	echo "$DIR seems to be in use! Starting up..."
else
	cp -av /usr/local/wso2emm/repository_original/. $DIR
fi

/usr/local/wso2emm/bin/wso2server.sh
