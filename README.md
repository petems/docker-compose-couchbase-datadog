# docker-compose-couchbase-datadog

A simple docker-compose setup to show how to send custom metrics and events to Datadog from a Couchbase instance

# Setup

- Create a `.env` file containing your API key and which Datadog site to send your data to (eg. `DD_SITE=datadoghq.eu` if you're using the EU site)
- Run `docker-compose build`
- Run `docker-compose up -d` 
- Run `docker-compose logs couchbase` and wait for the database to be ready:

<details>
- <summary>Click to unwrap loud startup logs</summary>

```
couchbase-1  | Starting Couchbase Server -- Web UI available at http://<ip>:8091
couchbase-1  | and logs available in /opt/couchbase/var/lib/couchbase/logs
couchbase-1  | Configuring Couchbase Server.  Please wait (~60 sec)...
couchbase-1  | Waiting for http://127.0.0.1:8091/ui/index.html to be available...
couchbase-1  | http://127.0.0.1:8091/ui/index.html not up yet, waiting 2 seconds...
couchbase-1  | http://127.0.0.1:8091/ui/index.html not up yet, waiting 2 seconds...
couchbase-1  | http://127.0.0.1:8091/ui/index.html not up yet, waiting 2 seconds...
couchbase-1  | http://127.0.0.1:8091/ui/index.html not up yet, waiting 2 seconds...
couchbase-1  | http://127.0.0.1:8091/ui/index.html ready, continuing
couchbase-1  | Setting memory quotas with curl
couchbase-1  |
couchbase-1  | Configuring Services with curl
couchbase-1  |
couchbase-1  | Setting up credentials with curl
couchbase-1  | {"newBaseUri":"http://127.0.0.1:8091/"}
couchbase-1  | Enabling memory-optimized indexes with curl
couchbase-1  | {"redistributeIndexes":false,"numReplica":0,"enablePageBloomFilter":false,"indexerThreads":0,"memorySnapshotInterval":200,"stableSnapshotInterval":5000,"maxRollbackPoints":2,"logLevel":"info","storageMode":"memory_optimized"}
couchbase-1  | Creating 'datadog-test' bucket with curl
couchbase-1  |
couchbase-1  | Creating RBAC 'admin' user on datadog-test bucket
couchbase-1  | SUCCESS: User admin set
couchbase-1  |
couchbase-1  | Adding document to test bucket with curl
couchbase-1  | {
couchbase-1  | "requestID": "9c5d7196-5e37-4253-bc6d-cb70adcbcf6f",
couchbase-1  | "signature": null,
couchbase-1  | "results": [
couchbase-1  | ],
couchbase-1  | "status": "success",
couchbase-1  | "metrics": {"elapsedTime": "32.448458ms","executionTime": "30.972625ms","resultCount": 0,"resultSize": 0,"serviceLoad": 2,"mutationCount": 1}
couchbase-1  | }
couchbase-1  |
couchbase-1  | Creating test FTS index with curl
couchbase-1  | Waiting for http://127.0.0.1:8094/api/index to be available...
couchbase-1  | http://127.0.0.1:8094/api/index ready, continuing
couchbase-1  | {"status":"ok","uuid":"428aecd7e90f9970"}
couchbase-1  |
couchbase-1  | Creating datadoc design document
couchbase-1  | {"ok":true,"id":"_design/datadoc"}
couchbase-1  |
couchbase-1  | Creating datatest analytics dataset
couchbase-1  | Waiting for http://127.0.0.1:8095/query/service to be available...
couchbase-1  | http://127.0.0.1:8095/query/service not up yet, waiting 2 seconds...
couchbase-1  | http://127.0.0.1:8095/query/service not up yet, waiting 2 seconds...
couchbase-1  | http://127.0.0.1:8095/query/service not up yet, waiting 2 seconds...
couchbase-1  | http://127.0.0.1:8095/query/service not up yet, waiting 2 seconds...
couchbase-1  | http://127.0.0.1:8095/query/service ready, continuing
couchbase-1  | {
couchbase-1  | 	"requestID": "1abd6a83-49ac-4254-9ce5-0983d2f8c94e",
couchbase-1  | 	"signature": {
couchbase-1  | 		"*": "*"
couchbase-1  | 	},
couchbase-1  | 	"plans":{},
couchbase-1  | 	"status": "success",
couchbase-1  | 	"metrics": {
couchbase-1  | 		"elapsedTime": "1.747210334s",
couchbase-1  | 		"executionTime": "1.728333626s",
couchbase-1  | 		"resultCount": 0,
couchbase-1  | 		"resultSize": 0,
couchbase-1  | 		"processedObjects": 0
couchbase-1  | 	}
couchbase-1  | }
couchbase-1  |
couchbase-1  | Configuration completed!
couchbase-1  | Couchbase Admin UI: http://localhost:8091
couchbase-1  | Login credentials: Administrator / password
couchbase-1  | Stopping config-couchbase service
couchbase-1  | ok: down: /etc/service/config-couchbase: 1s, normally up
```
- Check the Datadog agent check to see if the metrics are being sent: 
```
$ docker exec -it datadog-agent /opt/datadog-agent/bin/agent/agent check couchbase
=== Series ===
[
  {
    "metric": "couchbase.by_bucket.hibernated_waked",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.ram.used",
    "points": [
      [
        1710495516,
        7.38054144e+09
      ]
    ],
    "tags": [
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_active_queue_drain",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.decr_misses",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.disk_write_queue",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_dcp_fts_items_sent",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.xdc_ops",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.swap_total",
    "points": [
      [
        1710495516,
        1.073737728e+09
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_active_resident_items_ratio",
    "points": [
      [
        1710495516,
        100
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.cmd_lookup",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.couch_spatial_ops",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_flusher_todo",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ops",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_pending_queue_drain",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.couch_total_disk_size",
    "points": [
      [
        1710495516,
        8.5029e+06
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.bytes_read",
    "points": [
      [
        1710495516,
        99.3
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_dcp_other_total_bytes",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.mem_actual_free",
    "points": [
      [
        1710495516,
        4.870017024e+09
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_avg_active_queue_age",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.couch_views_disk_size",
    "points": [
      [
        1710495516,
        18178
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_mem_high_wat",
    "points": [
      [
        1710495516,
        8.912896e+07
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_vb_total",
    "points": [
      [
        1710495516,
        1024
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_active_num",
    "points": [
      [
        1710495516,
        1024
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_pending_ops_create",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.bytes_written",
    "points": [
      [
        1710495516,
        58902.4
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_max_size",
    "points": [
      [
        1710495516,
        1.048576e+08
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.curr_items_tot",
    "points": [
      [
        1710495516,
        1
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_dcp_other_items_remaining",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.incr_hits",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_pending_ops_update",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_replica_num",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_node.get_hits",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "device:172.26.0.2:8091",
      "instance:http://couchbase:8091",
      "node:172.26.0.2:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.couch_spatial_disk_size",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.curr_items",
    "points": [
      [
        1710495516,
        1
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_pending_queue_fill",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.hdd.used",
    "points": [
      [
        1710495516,
        1.0654086635e+10
      ]
    ],
    "tags": [
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.get_hits",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_pending_queue_age",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_replica_ops_update",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.ram.quota_used_per_node",
    "points": [
      [
        1710495516,
        1.048576e+08
      ]
    ],
    "tags": [
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_diskqueue_items",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_dcp_fts_items_remaining",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_num_ops_set_meta",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_num_ops_set_ret_meta",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.misses",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_node.vb_active_num_non_resident",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "device:172.26.0.2:8091",
      "instance:http://couchbase:8091",
      "node:172.26.0.2:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.couch_docs_fragmentation",
    "points": [
      [
        1710495516,
        95
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.avg_disk_update_time",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.swap_used",
    "points": [
      [
        1710495516,
        536576
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_dcp_views_total_bytes",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.mem_total",
    "points": [
      [
        1710495516,
        8.221937664e+09
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.get_misses",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_node.vb_replica_curr_items",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "device:172.26.0.2:8091",
      "instance:http://couchbase:8091",
      "node:172.26.0.2:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_replica_resident_items_ratio",
    "points": [
      [
        1710495516,
        100
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_num_value_ejects",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_avg_total_queue_age",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.couch_views_ops",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_active_queue_age",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_pending_curr_items",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_replica_eject",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_node.couch_spatial_disk_size",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "device:172.26.0.2:8091",
      "instance:http://couchbase:8091",
      "node:172.26.0.2:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.ram.quota_total",
    "points": [
      [
        1710495516,
        2.68435456e+08
      ]
    ],
    "tags": [
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.hit_ratio",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_dcp_fts_total_bytes",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_mem_low_wat",
    "points": [
      [
        1710495516,
        7.86432e+07
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_meta_data_memory",
    "points": [
      [
        1710495516,
        68
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_active_eject",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_replica_num_non_resident",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_replica_queue_fill",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.hdd.quota_total",
    "points": [
      [
        1710495516,
        6.2671097856e+10
      ]
    ],
    "tags": [
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.disk_commit_count",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_node.cmd_get",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "device:172.26.0.2:8091",
      "instance:http://couchbase:8091",
      "node:172.26.0.2:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_ops_update",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_pending_eject",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_pending_num_non_resident",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_pending_queue_size",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_replica_queue_age",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_replica_queue_drain",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.cas_misses",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_kv_size",
    "points": [
      [
        1710495516,
        131236
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_node.couch_docs_actual_disk_size",
    "points": [
      [
        1710495516,
        8.484722e+06
      ]
    ],
    "tags": [
      "device:172.26.0.2:8091",
      "instance:http://couchbase:8091",
      "node:172.26.0.2:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_node.curr_items_tot",
    "points": [
      [
        1710495516,
        1
      ]
    ],
    "tags": [
      "device:172.26.0.2:8091",
      "instance:http://couchbase:8091",
      "node:172.26.0.2:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_queue_size",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_node.curr_items",
    "points": [
      [
        1710495516,
        1
      ]
    ],
    "tags": [
      "device:172.26.0.2:8091",
      "instance:http://couchbase:8091",
      "node:172.26.0.2:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_replica_ops_create",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_node.couch_views_actual_disk_size",
    "points": [
      [
        1710495516,
        18178
      ]
    ],
    "tags": [
      "device:172.26.0.2:8091",
      "instance:http://couchbase:8091",
      "node:172.26.0.2:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_node.couch_views_data_size",
    "points": [
      [
        1710495516,
        18178
      ]
    ],
    "tags": [
      "device:172.26.0.2:8091",
      "instance:http://couchbase:8091",
      "node:172.26.0.2:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_dcp_fts_producer_count",
    "points": [
      [
        1710495516,
        1
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_num_ops_get_meta",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_active_ops_create",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.hibernated_requests",
    "points": [
      [
        1710495516,
        14
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.mem_used_sys",
    "points": [
      [
        1710495516,
        7.387242496e+09
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.disk_update_count",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_bg_fetched",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_avg_replica_queue_age",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_avg_pending_queue_age",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.bg_wait_total",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_diskqueue_drain",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.ram.quota_used",
    "points": [
      [
        1710495516,
        1.048576e+08
      ]
    ],
    "tags": [
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_resident_items_rate",
    "points": [
      [
        1710495516,
        100
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_active_num_non_resident",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.hdd.total",
    "points": [
      [
        1710495516,
        6.2671097856e+10
      ]
    ],
    "tags": [
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.incr_misses",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_num_non_resident",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_num_ops_del_ret_meta",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.couch_views_fragmentation",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.delete_misses",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_item_commit_failed",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_pending_num",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.cpu_utilization_rate",
    "points": [
      [
        1710495516,
        1.4081795442115
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_node.couch_docs_data_size",
    "points": [
      [
        1710495516,
        396835
      ]
    ],
    "tags": [
      "device:172.26.0.2:8091",
      "instance:http://couchbase:8091",
      "node:172.26.0.2:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.hdd.used_by_data",
    "points": [
      [
        1710495516,
        8.5029e+06
      ]
    ],
    "tags": [
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.couch_docs_actual_disk_size",
    "points": [
      [
        1710495516,
        8.484722e+06
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_num_ops_del_meta",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_replica_curr_items",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.couch_docs_disk_size",
    "points": [
      [
        1710495516,
        8.448045e+06
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.decr_hits",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_dcp_views_backoff",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_diskqueue_fill",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_pending_meta_data_memory",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_pending_resident_items_ratio",
    "points": [
      [
        1710495516,
        100
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.avg_bg_wait_time",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_active_queue_fill",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.rest_requests",
    "points": [
      [
        1710495516,
        2.399520095980804
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.avg_disk_commit_time",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_tmp_oom_errors",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_total_queue_age",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_node.couch_spatial_data_size",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "device:172.26.0.2:8091",
      "instance:http://couchbase:8091",
      "node:172.26.0.2:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.cmd_set",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_dcp_fts_backoff",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_cache_miss_rate",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.mem_actual_used",
    "points": [
      [
        1710495516,
        3.35192064e+09
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.hdd.free",
    "points": [
      [
        1710495516,
        5.2017011221e+10
      ]
    ],
    "tags": [
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_dcp_views_items_sent",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.couch_views_data_size",
    "points": [
      [
        1710495516,
        18178
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_dcp_other_items_sent",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_active_queue_size",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_replica_meta_data_memory",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.ram.total",
    "points": [
      [
        1710495516,
        8.221937664e+09
      ]
    ],
    "tags": [
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.ram.used_by_data",
    "points": [
      [
        1710495516,
        3.217704e+07
      ]
    ],
    "tags": [
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_active_meta_data_memory",
    "points": [
      [
        1710495516,
        68
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_node.mem_used",
    "points": [
      [
        1710495516,
        3.217704e+07
      ]
    ],
    "tags": [
      "device:172.26.0.2:8091",
      "instance:http://couchbase:8091",
      "node:172.26.0.2:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_node.ops",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "device:172.26.0.2:8091",
      "instance:http://couchbase:8091",
      "node:172.26.0.2:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.ram.quota_total_per_node",
    "points": [
      [
        1710495516,
        2.68435456e+08
      ]
    ],
    "tags": [
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_dcp_fts_count",
    "points": [
      [
        1710495516,
        1
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_dcp_views_producer_count",
    "points": [
      [
        1710495516,
        1
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.cas_hits",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.couch_spatial_data_size",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_dcp_views_items_remaining",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_oom_errors",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_replica_queue_size",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.couch_docs_data_size",
    "points": [
      [
        1710495516,
        396835
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.curr_connections",
    "points": [
      [
        1710495516,
        46
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.delete_hits",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_dcp_views_count",
    "points": [
      [
        1710495516,
        1
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_ops_create",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.ep_overhead",
    "points": [
      [
        1710495516,
        4.974294e+06
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.mem_used",
    "points": [
      [
        1710495516,
        3.217704e+07
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.vb_active_ops_update",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.cas_badval",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.cmd_get",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_bucket.mem_free",
    "points": [
      [
        1710495516,
        4.870017024e+09
      ]
    ],
    "tags": [
      "bucket:datadog-test",
      "device:datadog-test",
      "instance:http://couchbase:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  },
  {
    "metric": "couchbase.by_node.ep_bg_fetched",
    "points": [
      [
        1710495516,
        0
      ]
    ],
    "tags": [
      "device:172.26.0.2:8091",
      "instance:http://couchbase:8091",
      "node:172.26.0.2:8091"
    ],
    "host": "localpro",
    "type": "gauge",
    "interval": 0,
    "source_type_name": "System"
  }
]
=== Service Checks ===
[
  {
    "check": "couchbase.can_connect",
    "host_name": "localpro",
    "timestamp": 1710495516,
    "status": 0,
    "message": "",
    "tags": [
      "instance:http://couchbase:8091"
    ]
  },
  {
    "check": "couchbase.by_node.cluster_membership",
    "host_name": "localpro",
    "timestamp": 1710495516,
    "status": 0,
    "message": "",
    "tags": [
      "instance:http://couchbase:8091",
      "node:172.26.0.2:8091"
    ]
  },
  {
    "check": "couchbase.by_node.health",
    "host_name": "localpro",
    "timestamp": 1710495516,
    "status": 0,
    "message": "",
    "tags": [
      "instance:http://couchbase:8091",
      "node:172.26.0.2:8091"
    ]
  }
]
=========
Collector
=========

  Running Checks
  ==============

    couchbase (3.1.0)
    -----------------
      Instance ID: couchbase:600b35b1912dd329 [OK]
      Configuration Source: file:/etc/datadog-agent/conf.d/couchbase.yaml
      Total Runs: 1
      Metric Samples: Last Run: 163, Total: 163
      Events: Last Run: 0, Total: 0
      Service Checks: Last Run: 3, Total: 3
      Average Execution Time : 211ms
      Last Execution Date : 2024-03-15 09:38:36 UTC (1710495516000)
      Last Successful Execution Date : 2024-03-15 09:38:36 UTC (1710495516000)


  Metadata
  ========
    config.hash: couchbase:600b35b1912dd329
    config.provider: file
    version.build: enterprise
    version.raw: 7.1.1-3175+enterprise
    version.scheme: semver
    version.major: 7
    version.minor: 1
    version.patch: 1
    version.release: 3175
Check has run only once, if some metrics are missing you can try again with --check-rate to see any other metric if available.
This check type has 1 instances. If you're looking for a different check instance, try filtering on a specific one using the --instance-filter flag or set --discovery-min-instances to a higher value
```

</details>

- Check in your Datadog org that you can see the Couchbase metrics in the Dashboard:
![image](https://github.com/petems/docker-compose-couchbase-datadog/assets/1064715/bbb44253-b01d-400c-bd92-6e9e1bfb067d)

## Caveats 
* **DO NOT USE THIS SETUP IN PRODUCTION**: The username and password are hardcoded to Administrator/Password
* This is a very simple development deployment, just 1 cluster

