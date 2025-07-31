#!/bin/bash

readonly SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

cd $SCRIPTPATH

docker pull docker.io/php:8.3-fpm-alpine
docker compose build php
docker compose up -d
