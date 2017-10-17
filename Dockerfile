FROM ubuntu:16.04

# Setup environment
ENV DEBIAN_FRONTEND noninteractive

# Install common
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y vim wget curl bash-completion zip unzip fping openvpn psmisc

# Install python 3.6 
RUN \
  add-apt-repository ppa:jonathonf/python-3.6 && \
  apt-get update && \
  apt-get install -y python3.6 python3.6-dev && \
  rm -f /usr/bin/python && ln -s /usr/bin/python3.6 /usr/bin/python

# Install python pip
RUN wget https://bootstrap.pypa.io/get-pip.py && \
  python get-pip.py && \
  rm -f /usr/bin/pip && ln -s /usr/local/bin/pip /usr/bin/pip && \
  rm get-pip.py
  
# Install mysql connector for python
RUN pip install mysql-connector-python-rf

# Install couchbase dev tools
RUN wget http://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-2-amd64.deb && \
  dpkg -i couchbase-release-1.0-2-amd64.deb && \
  apt-get update && \
  apt-get -y install libcouchbase-dev build-essential && \
  pip install couchbase && \
  rm couchbase-release-1.0-2-amd64.deb && \
  rm -rf /var/lib/apt/lists/*

# Install HMA
RUN wget https://s3.amazonaws.com/hma-zendesk/linux/hma-linux.zip && \
  unzip hma-linux.zip -d /opt/ && \
  chmod +x /opt/hma-linux/hma-vpn.sh && \
  rm hma-linux.zip

CMD ["python"]

