## Configset container build

This will build a container and copy the configset directories into the image
as a configset.  This is built off of the stock solr docker image.  You can use
the configset to pre-populate a core using the solr docker image command
"solr-precreate" (see
https://github.com/docker-solr/docker-solr-examples/tree/master/custom-configset)

This image can be used to create cores from many configsets

### Jenkinsfile

There is an included Jenkinsfile that will configure a jenkins job in an
appropriately configured jenkins setup.

### docker-compose.yml

The included docker-compose.yml should bring up a container with the correct
config, and can be used as an example for production.  There are commented out
commands to allow you to select which core you'd like to create when the
container starts.


