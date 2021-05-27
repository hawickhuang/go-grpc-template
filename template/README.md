# {{Name}}

## Feature

* Your fancy feature.

## Service Design Goal

### Scalability

Linear < N nodes, scale with sharding. No auto scale.

### Availability

Read-only on shard master failure. Failover with leader election on shard-proxy failure.

### Durability

Depends on Cassandra, storage.

### Consistency

Eventual

### Performance

* \>2000 queries for 1M DB per GPU (batching)

## API Design

* gRPC: refer to `pb/{{Name}}.proto`

## Implementation

### Overview

Your architecture figure here.

### Tradeoff:

1. Eventual consistency for slaves

### DB Schema

```sql
# SQL HERE
```

### In-memory/persisted states

Metadata:

* Index meta: filesystem, JSON
* DB meta: Cassandra

Features:

### Replication

How to do HA?

### Failure recovery

TODO

### Optimization

* Some optimization

## Dependencies

### Infrastructure

* Shared Storage for replicaset snapshots (NAS/Ceph)
* Cassandra + SSD

### SDKs

* some_sdk

### Services

None.


## Development

### Environment

* golang1.15

### Build

* make

### Run

* ./cmd/{{Name}}
* curl localhost:8888

### Test

* make test

## Contact us

* If u need any support, pls contact [hawick.huang@gmail.com](mailto:hawick.huang@gmail.com).
* If u have any suggestion or comment, pls create an issue.
* If u like this project or vce, pls give us a star.