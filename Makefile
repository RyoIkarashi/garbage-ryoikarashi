#
# intialize wordpress
#
init:
	# WordPress Core Install
	./scripts/wp/wp-core-install.sh

	# Install Plugins
	./scripts/wp/wp-install-plugins.sh

#
# Development command
#
dev:
	# Create docker containers
	./scripts/dev.sh

#
# Development command
#
rebuild:
	# Rebuild docker containers
	docker-compose up -d --build
