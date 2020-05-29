FROM ubuntu:18.04

RUN apt-get update && apt-get -y install wget
RUN	wget https://github.com/EOSIO/eos/releases/download/v2.0.3/eosio_2.0.3-1-ubuntu-18.04_amd64.deb && \
	apt-get -y install ./eosio_2.0.3-1-ubuntu-18.04_amd64.deb

