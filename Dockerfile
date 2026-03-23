FROM docker.io/solr:10.0

COPY configsets/site-search/ /opt/solr/server/solr/configsets/site-search/

USER root
# we want jq for api parsing
RUN apt update && apt install -y jq openssh-client \
    && rm -rf /var/lib/apt/lists/*
# create solr's home dir so ssh doesn't complain
RUN mkdir /home/solr && chown solr /home/solr
COPY crepo_files/crepo /usr/local/bin/crepo
USER solr
