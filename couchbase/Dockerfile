FROM sabrenner/couchbase-server-sandbox:latest

RUN apt-get update -y 
RUN apt-get install --reinstall bash
COPY scripts/configure-node.sh /etc/service/config-couchbase/run