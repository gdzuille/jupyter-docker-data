ARG debian_buster_image_tag=8-jre-slim
FROM openjdk:${debian_buster_image_tag}

ARG workspace=/opt/workspace
ARG Python=3.11.3

ENV PYSPARK_PYTHON=/usr/local/bin/python3.11

RUN mkdir -p ${workspace} && \
    apt-get update -y && \
    apt-get install -y --fix-missing curl gcc build-essential zlib1g-dev libncurses5-dev libsqlite3-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget libjpeg-dev && \
    curl -O https://www.python.org/ftp/python/${Python}/Python-${Python}.tgz && \
    tar xzf Python-${Python}.tgz && \
    cd Python-${Python} && \
    ./configure && \
    make -j 8 && \
    make install && \
    apt-get update && \
    apt-get install -y --fix-missing procps vim net-tools && \
    rm -rf /var/lib/apt/lists/*

ENV workspace=${workspace}

VOLUME ${workspace}

# Copy requirements file to the image
COPY ./requirements.txt /tmp

RUN apt-get update -y && \
    apt-get install -y python3-pip && \
    apt-get clean

# Install required packages
RUN pip install --no-cache-dir -r /tmp/requirements.txt

EXPOSE 8888
WORKDIR ${workspace}

CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token=