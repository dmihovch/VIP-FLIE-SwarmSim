#!/usr/bin/env bash
# Clean up any failed attempts
docker compose down --remove-orphans

# Build with the new fix
docker compose build --no-cache

# Start the container
docker compose up -d
