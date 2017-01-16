#!/bin/bash

set -e

PLUGINS=(
  convert-post-types
  pubsubhubbub
  post-thumbnail-editor
  advanced-custom-fields-oembed-field
  acf-content-analysis-for-yoast-seo
  rest-api
  custom-post-type-ui
  simple-page-ordering
  post-duplicator
  download-attachments
  attachment-importer
  better-rest-api-featured-images
  wordpress-seo
  multi-device-switcher
  display-widgets
  search-everything
  wp-rest-api-post-type-taxonomies
  wordpress-importer
  acf-to-rest-api
  backwpup
  acf-theme-code
  ######### Translation ############
	# wp-seo-qtranslate-x
	# qtranslate-x
	# acf-qtranslate
)

PLUGINS_TO_REMOVE=(
  hello-dolly
)

WP_CONTAINER_NAME="garbage_wordpress"

ACF_PRO_KEY=`cat ./scripts/wp/wp-acf-pro-key.txt`

: "Installing plugins and removing unnecessary plugins" && {
  docker exec ${WP_CONTAINER_NAME} wp plugin install ${PLUGINS[*]};
  docker exec ${WP_CONTAINER_NAME} wp plugin activate ${PLUGINS[*]}
}

: "Download, install and activate ACF PRO if not installed yet" && {
  ACF_PLUGIN_NAME="advanced-custom-fields-pro"
  docker exec ${WP_CONTAINER_NAME} wp plugin list | grep ${ACF_PLUGIN_NAME} > /dev/null || {
    ACF_PLUGIN_DIRECTORY="/var/www/html/wp-content/plugins"
    ACF_ZIP_FILE="${ACF_PLUGIN_DIRECTORY}/${ACF_PLUGIN_NAME}.zip"
      docker exec ${WP_CONTAINER_NAME} wget -O ${ACF_ZIP_FILE} "http://connect.advancedcustomfields.com/index.php?p=pro&a=download&k=${ACF_PRO_KEY}"
      docker exec ${WP_CONTAINER_NAME} unzip -d ${ACF_PLUGIN_DIRECTORY} ${ACF_ZIP_FILE}
      docker exec ${WP_CONTAINER_NAME} wp plugin activate ${ACF_PLUGIN_NAME}
      docker exec ${WP_CONTAINER_NAME} rm ${ACF_ZIP_FILE}
  }
}

: "Rewriting structure" && {
  docker exec ${WP_CONTAINER_NAME} wp rewrite structure '/%postname%/'
}

: "Updating WordPress" && {
  docker exec ${WP_CONTAINER_NAME} wp core update
}
