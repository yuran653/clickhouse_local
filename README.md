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
    Create a `.env` file in the root directory with the necessary variables. You can run the following command to create a default one:
    ```bash
    echo 'CH_PASSWORD="password"' > .env
    ```

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

## Connecting with DBeaver

To connect to the ClickHouse cluster using [DBeaver](https://dbeaver.io/), use the following connection settings:

### Connection Details (Node 1)
- **Host**: `localhost`
- **Port**: `8123` (HTTP) or `9000` (Native)
- **Database**: `ch_datalake` (created automatically on startup)
- **Username**: `datalake`
- **Password**: The password defined in your `.env` (default: `password`)

### Connection Details (Node 2)
- **Host**: `localhost`
- **Port**: `18123` (HTTP) or `19000` (Native)
- **Database**: `ch_datalake`
- **Username**: `datalake`
- **Password**: The password defined in your `.env` (default: `password`)

> **Note**: For the best experience, use the **ClickHouse** driver in DBeaver.

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
