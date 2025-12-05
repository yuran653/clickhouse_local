#!/bin/bash

# Script to initialize volume directories required by docker-compose.yaml
# Run this script before `docker compose up` when starting fresh

set -e

GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RESET="\033[0m"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo -e "${YELLOW}Creating volume directories...${RESET}"

# Create ZooKeeper directories (needs version-2 subdirectory)
mkdir -p volumes/zk/data/version-2
mkdir -p volumes/zk/datalog
mkdir -p volumes/zk/logs

# Create ZooKeeper myid file (required for standalone mode)
echo "1" > volumes/zk/data/myid

# Create ClickHouse node 01 directories
mkdir -p volumes/01/data
mkdir -p volumes/01/logs

# Create ClickHouse node 02 directories
mkdir -p volumes/02/data
mkdir -p volumes/02/logs

# Create ClickHouse init container directories
mkdir -p volumes/ch-init/data
mkdir -p volumes/ch-init/logs

echo -e "${GREEN}Volume directories created successfully:${RESET}"
find volumes -type d | sort
