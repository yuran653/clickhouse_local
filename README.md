# ClickHouse Local Cluster

This project provides a local development environment for a 2-node ClickHouse cluster with Zookeeper, orchestrated using Docker Compose

## Prerequisites

-   [Docker](https://docs.docker.com/get-docker/)
-   [Docker Compose](https://docs.docker.com/compose/install/)

## Quick Start

1.  **Initialize Volumes**:
    Run the initialization script to create the necessary directory structure for persistent volumes
    ```bash
    ./init-volumes.sh
    ```

2.  **Configure Environment**:
    Ensure you have a `.env` file in the root directory. You can copy the example if provided or create one with necessary variables (e.g., `CH_PASSWORD`)

3.  **Start Services**:
    Launch the cluster in detached mode
    ```bash
    docker compose up -d
    ```

4.  **Verify Status**:
    Check if all containers are up and healthy
    ```bash
    docker compose ps
    ```

## Services

The cluster consists of the following services:

| Service Name | Container Name | Ports (HTTP / Native) | Description |
| :--- | :--- | :--- | :--- |
| `zookeeper` | `zookeeper` | `2181` (Client) | Zookeeper for ClickHouse distribution coordination |
| `clickhouse-01` | `clickhouse-01` | `8123` / `9000` | First ClickHouse node |
| `clickhouse-02` | `clickhouse-02` | `18123` / `19000` | Second ClickHouse node |
| `clickhouse-init-db` | `clickhouse-init-db` | - | Ephemeral container to initialize the database |

## Configuration

Configuration files are mapped from the local `etc/` directory to the containers:

-   `etc/config.d/`: Common ClickHouse server configuration
-   `etc/users.d/`: User management configuration
-   `etc/ch01/`: Specific configuration for Node 1
-   `etc/ch02/`: Specific configuration for Node 2

## Data Persistence

Data is persisted in the local `volumes/` directory (created by `init-volumes.sh`)
-   `volumes/zk`: Zookeeper data and logs
-   `volumes/01`: ClickHouse Node 1 data and logs
-   `volumes/02`: ClickHouse Node 2 data and logs
