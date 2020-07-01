FROM solr:8.2

COPY configsets/ /opt/solr/server/solr/configsets/
COPY core_repo /usr/local/bin/core_repo
