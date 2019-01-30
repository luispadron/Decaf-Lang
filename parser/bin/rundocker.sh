#!/bin/bash

docker build -t parser-docker .
docker run -t -i parser-docker
