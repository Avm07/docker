FROM ubuntu:18.04

# Arguments that may be overridden by the user
ARG release=latest

# Install required packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssl ca-certificates curl wget && rm -rf /var/lib/apt/lists/*

# Install CDT from deb package
ADD install_deb.sh /
RUN /install_deb.sh $release && rm -f install_deb.sh

RUN apt-get update && apt-get -y install cmake g++ git

RUN mkdir -p /opt/eosio && cd /opt/eosio && \
    git clone --recursive https://github.com/EOSIO/eos && \
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
