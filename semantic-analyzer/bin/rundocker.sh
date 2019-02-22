#!/bin/bash

docker build -t parser-docker .
docker run -t -i -v $(pwd)/:/src parser-docker
