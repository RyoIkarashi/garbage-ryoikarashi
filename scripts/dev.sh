#!/bin/sh

set -eux

: "detect project root path" && {
  ROOT_DIR=$(cd $(dirname $(dirname $0)); pwd)
  cd $ROOT_DIR
}

: "detect project name" && {
  PROJECT_NAME=$(basename $ROOT_DIR)
}

: "install npm packages" && {
	npm install
}

: "download latest docker images" && {
	docker-compose pull
}

: "start docker container" && {
	docker-compose up -d
}

: "start tmuxinator" && {
	mkdir -p $HOME/.tmuxinator
	cp $ROOT_DIR/tmuxinator.yml $HOME/.tmuxinator/$PROJECT_NAME.yml
	bash -c "sleep 3 && rm -f $HOME/.tmuxinator/$PROJECT_NAME.yml" &
	tmuxinator start $PROJECT_NAME
}
