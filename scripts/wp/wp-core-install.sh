#!/bin/sh

WP_CONTAINER_NAME=garbage_wordpress

docker exec $WP_CONTAINER_NAME wp core install \
								--url=localhost:3000 \
								--title=Garbage \
								--admin_user=admin \
								--admin_password=admin \
								--admin_email=admin@example.com

docker exec $WP_CONTAINER_NAME wp core update
