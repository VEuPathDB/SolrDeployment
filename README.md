## Basic Solr Configuration
### 1. Spin up the Docker containers
In the directory that contains `docker-compose.yml`, do
```
docker-compose up --build -d
```
This creates a couple of containers and volumes. One volume to note is `github_volume_solrdata_v1`. This volume contains the cores that Solr uses and any new cores will be added there.

### 2. Add a new Solr core (if needed)
If you want to add a new Solr core, then do
```
docker exec -it container_name solr create_core -c new_core_name
```
This creates a new core in a new directory `new_core_name` within the volume mentioned above. Note that this by default creates a schemaless (auto-managed) core, but our solrconfig.xml will change it to a classic (manual) schema configuration.

### 3. Stop all containers
After changing Solr configuration files for a core, you need to restart Solr. We do this by restarting the containers. We'll go ahead and stop them now. Note that this command will stop all running containers, not just the ones started above, so if there are other docker containers running, you'll need to explicitly list the IDs of the Solr containers instead of `$(docker ps -aq)`.
```
docker stop $(docker ps -aq)
```

### 4. Import configuration files
Copy the files from the correct directory in this repo (eg `site_search_config`) into the core's conf directory, which will be located at `.../github_volume_solrdata_v1/_data/data/[core_name]/conf`.

### 5. Start the containers again
```
docker-compose up --build -d
```

## More information
More info can be found at https://docs.google.com/document/d/1_2LEMEOFZ_cCTtUWVQvNtXnodP6vwiLkxJFoZKK-Vwo/edit?usp=sharing. This is a guide for running Solr from Docker for VectorBase, so not everything is relevant.