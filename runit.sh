#!/bin/bash
set -e

USER_ID=${USER_ID:-"www-data"}

if [ "$1" == 'nginx' ]; then
    shift 1
    echo "Running nginx $@"

    # Set user and group for php-fpm process
    if ! [ "$USER_ID" == 'www-data' ] ; then 
        adduser $USER_ID
        sed -i -e "s/^user .*/user $USER_ID;/"    /etc/nginx/nginx.conf
    fi

    exec nginx "$@"

else 
    echo "Running command: $@"
    exec "$@"   

fi

