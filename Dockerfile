FROM solr:8.2

COPY configsets/ /opt/solr/server/solr/configsets/

USER root
# create solr's home dir so ssh doesn't complain
RUN mkdir /home/solr && chown solr /home/solr
COPY core_repo /usr/local/bin/core_repo
USER solr
