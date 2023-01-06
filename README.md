# Data Engineering: Local environment with Apache Spark and Kafka clusters

This repository showcases a local environment for data engineers, leveraging the use of Docker containers to bootstrap Apache Spark and Kafka clusters.

The main goal is to provide you with a local environment to accelerate testing the distributed nature of your Spark apps without making any deploy to a production cluster (e.g. Kubernetes or Databricks).

## Getting Started

### Creating the Spark cluster

Build and run the standalone cluster:

```
docker-compose up
```

Then you can access the Spark main UI on `http://localhost:9090` and worker 1 on `http://localhost:9091`.

### Running the application

> WIP

### Stopping the cluster

If you need to stop a specific worker:

```
docker|podman stop spark-worker-<ID>
```

If you need to stop the full cluster, it's recommended to stop all workers first, then stop the Spark main node:

```
docker|podman stop spark-main
```

## References

- [Creating a Spark Standalone Cluster with Docker and docker-compose(2021 update)](https://dev.to/mvillarrgccealb/creating-a-spark-standalone-cluster-with-docker-and-docker-compose-2021-update-6l4)
