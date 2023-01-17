# Data Engineering: Local environment for Apache Spark and Kafka clusters

This repository showcases a local environment for data engineers, leveraging the use of Docker containers to bootstrap Apache Spark and Kafka clusters for streaming scenarios.

The main goal is to provide you with a local environment to accelerate testing the distributed nature of your Spark apps without making any deploy to a production cluster (e.g. Kubernetes or Databricks).

## About the solution

The solution was designed to be as minimal as possible to validate the Kafka integration with a Spark application in a local environment.

- A producer service (`.kafka` file) sends fake messages in JSON format with random values to a Kafka topic;
- The Spark application (Python) consumes messages from the Kafka topic and print out the key/value schemas to the console.

## Prerequisites

- For Docker users: [Docker Desktop](https://docs.docker.com/compose/install/)
- For Podman users: [Podman](https://podman.io/getting-started/installation) and [podman-compose](https://github.com/containers/podman-compose)
- [Visual Studio Code](https://code.visualstudio.com/download) with [Tools for Apache Kafka®](https://marketplace.visualstudio.com/items?itemName=jeppeandersen.vscode-kafka) extension

## Getting Started

### Containers overview

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


### Kafka producer

The repository contains a `producer.kafka` file definition for the production of fake Kafka messages with random values. To use it, open the file on Visual Studio Code and make sure you have the [Tools for Apache Kafka®](https://marketplace.visualstudio.com/items?itemName=jeppeandersen.vscode-kafka) extension installed.

Use the extension to create a new cluster, then click on `Produce record` or `Produce record x 10`. Once it's done, the Spark application will be ready to consume those generated menssages.

### Spark app deployment     

Access a Spark worker container:

```
docker|podman exec -it spark-worker-<ID> bash
```

Then use the `spark-submit` command to run your application. The example below submits the `main.py` file with 1GB memory allocation for the driver and executor:

```
/opt/spark/bin/spark-submit \
    --packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.0.2 \
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
- [Structured Streaming + Kafka Integration Guide (Kafka broker version 0.10.0 or higher)](https://spark.apache.org/docs/2.2.0/structured-streaming-kafka-integration.html)