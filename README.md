# Data Engineering: Local environment for Apache Spark and Kafka clusters

This repository showcases a local environment for data engineers, leveraging the use of Docker containers to bootstrap Apache Spark and Kafka clusters.

The main goal is to provide you with a local environment to accelerate testing the distributed nature of your Spark apps without making any deploy to a production cluster (e.g. Kubernetes or Databricks).

## Getting Started

The `docker-compose.yml` file available on this repository defines the following Docker containers by default:

| Domain       | Container name | Description                                   | Entrypoint URL        |
| ------------ | -------------- | --------------------------------------------- | --------------------- |
| Apache Spark | spark-main     | Spark main node                               | http://localhost:9090 |
|              | spark-worker-1 | A Spark worker instance                       | http://localhost:9091 |
| Apache Kafka | zookeeper      | ZooKeeper instance for metadata management    | N/A                   |
|              | kafka          | Community version of Confluent Kafka platform | http://localhost:9092 |
|              | kafdrop        | UI for viewing Kafka topics/consumer groups   | http://localhost:9000 |

> `kafdrop` is optional, so if you want to save resources and/or aren't interested on using the UI, you can open the Docker compose file and delete/comment its service definition.

> If you need more Spark worker instances, update the Docker compose file to include new `spark-worker-<N>` service(s) using the same config structure used on the `spark-worker-1` with different values for ports and `SPARK_LOCAL_IP` environment values.

### Environment setup

Build and run the resources with Docker or Podman:

```
docker-compose|podman-compose up
```

> For better experience, you can run the containers in detached mode with the `-d` flag.

### Spark app deployment

Access a Spark worker container:

```
docker|podman exec -it spark-worker-<ID> bash
```

Then use the `spark-submit` command to run your application. The example below submits the `main.py` file with 1GB memory allocation for the driver and executor:

```
/opt/spark/bin/spark-submit \
    --master spark://spark-master:7077 \
    --driver-memory 1G \
    --executor-memory 1G \
    /opt/spark-apps/main.py
```

### Cleanup

If you need to stop all resources:

```
docker-compose|podman-compose stop
```

If you want to stop a specific service:

```
docker-compose|podman-compose stop <service-name>
```

## References

- [Creating a Spark Standalone Cluster with Docker and docker-compose(2021 update)](https://dev.to/mvillarrgccealb/creating-a-spark-standalone-cluster-with-docker-and-docker-compose-2021-update-6l4)
