#!/usr/bin/env bash

echo "Checking Datadog agent"
docker exec -it datadog-agent /opt/datadog-agent/bin/agent/agent check couchbase