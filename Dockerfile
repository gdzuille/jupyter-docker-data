ARG debian_buster_image_tag=8-jre-slim
FROM openjdk:${debian_buster_image_tag}

ARG workspace=/opt/workspace

RUN mkdir -p ${workspace} && \
    apt-get update -y && \
	apt install -y curl gcc &&\ 
	apt install -y build-essential zlib1g-dev libncurses5-dev && \
	apt install -y libsqlite3-dev && \
	apt install -y libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget libjpeg-dev && \
	curl -O https://www.python.org/ftp/python/3.8.10/Python-3.8.10.tar.xz  && \
    tar -xf Python-3.8.10.tar.xz && cd Python-3.8.10 && ./configure && make -j 8 &&\
    make install && \
    apt-get update && apt-get install -y procps && apt-get install -y vim && apt-get install -y net-tools && \
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