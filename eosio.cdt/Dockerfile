FROM ubuntu:18.04

# Arguments that may be overridden by the user
ARG BUILD_CDT_VERSION=1.7.0
ARG BUILD_NODEOS_VERSION=2.1.0

# Install required packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssl ca-certificates curl wget && rm -rf /var/lib/apt/lists/*

# Install CDT from deb package
RUN wget https://github.com/EOSIO/eosio.cdt/releases/download/v${BUILD_CDT_VERSION}/eosio.cdt_${BUILD_CDT_VERSION}-1-ubuntu-18.04_amd64.deb
RUN apt install ./eosio.cdt_${BUILD_CDT_VERSION}-1-ubuntu-18.04_amd64.deb

RUN apt-get update && apt-get -y install cmake g++ git

RUN mkdir -p /opt/eosio && cd /opt/eosio && \
    git clone --recursive -j8 -b v${BUILD_NODEOS_VERSION} --depth 1 https://github.com/EOSIO/eos && \
    cd /opt/eosio/eos && \
    ./scripts/eosio_build.sh -y && \
    ./scripts/eosio_install.sh 
    
RUN cd /tmp && wget http://downloads.sourceforge.net/project/boost/boost/1.70.0/boost_1_70_0.tar.gz \
      && tar xfz boost_1_70_0.tar.gz \
      && rm boost_1_70_0.tar.gz \
      && cd boost_1_70_0 \
      && ./bootstrap.sh --prefix=/usr/local --with-libraries=date_time,filesystem,system,chrono,iostreams,regex,test \
      && ./b2 install link=static

USER root
