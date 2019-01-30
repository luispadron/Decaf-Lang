FROM ubuntu:trusty
RUN apt-get update
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    make \
    bison \
    flex
CMD ["/bin/bash"]
WORKDIR /src
COPY . /src

