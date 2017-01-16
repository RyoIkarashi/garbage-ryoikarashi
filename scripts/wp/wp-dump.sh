#!/bin/sh

DB_CONTAINER_NAME="garbage_db"
DB_NAME="garbage"
docker exec -i ${DB_CONTAINER_NAME} sh -c "mysqldump ${DB_NAME} -u admin -padmin" > ./db-data/db_wordpress.sql
