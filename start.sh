#!/usr/bin/env bash

xhost +local:docker
docker compose up -d --build
docker exec -it ros2_drone_dev bash

