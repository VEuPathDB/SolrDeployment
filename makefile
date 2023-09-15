.PHONY: default
default:
	echo "Usage:"
	echo "  make docker - Builds the docker image."
	echo ""
	echo "  make run    - Runs the docker image"

.PHONY: docker
build:
	docker build -t veupathdb/solr:latest .

.PHONY: run
run:
	docker run -it --rm -p "8983:8983" --env=SOLR_HEAP=5G veupathdb/solr:latest