FROM gcc:latest

RUN wget https://github.com/Kitware/CMake/releases/download/v3.14.3/cmake-3.14.3-Linux-x86_64.sh \
      -q -O /tmp/cmake-install.sh \
      && chmod u+x /tmp/cmake-install.sh \
      && mkdir /usr/bin/cmake \
      && /tmp/cmake-install.sh --skip-license --prefix=/usr/bin/cmake \
      && rm /tmp/cmake-install.sh

ENV PATH="/usr/bin/cmake/bin:${PATH}"

RUN cd /tmp && wget http://downloads.sourceforge.net/project/boost/boost/1.70.0/boost_1_70_0.tar.gz \
      && tar xfz boost_1_70_0.tar.gz \
      && rm boost_1_70_0.tar.gz \
      && cd boost_1_70_0 \
      && ./bootstrap.sh --prefix=/usr/local --with-libraries=program_options,date_time,system,filesystem,thread,regex,chrono,atomic,iostreams,locale,test \
      && ./b2 install link=static \
      && cd /home

RUN apt-get update && apt-get -y install pkg-config libssl-dev libsasl2-dev libpthread-stubs0-dev -y

RUN cd /tmp && wget https://raw.githubusercontent.com/libbitcoin/libbitcoin/version3/install.sh \
    && chmod +x install.sh \
    && ./install.sh --disable-shared

RUN cd /tmp && wget https://github.com/randombit/botan/archive/2.14.0.tar.gz \
    && tar -xzf 2.14.0.tar.gz \
    && cd ./botan-2.14.0 \
    && ./configure.py \
    && make && make install

RUN cd /tmp && cd /tmp && wget https://github.com/gabime/spdlog/archive/v1.5.0.tar.gz \
    && tar xzf v1.5.0.tar.gz \
    && cd ./spdlog-1.5.0 && mkdir build && cd build \
    && cmake .. && make -j && make install

RUN cd /tmp && wget https://github.com/nlohmann/json/archive/v3.8.0.tar.gz \
    && tar xzf v3.8.0.tar.gz \
    && cd ./json-3.8.0 && mkdir build && cd build \
    && cmake -DBUILD_TESTING=OFF .. && make -j && make install

RUN ldconfig -v
