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
      && ./bootstrap.sh --prefix=/usr/local --with-libraries=program_options,date_time,log,system,filesystem,thread,regex,chrono,atomic,iostreams,locale,test \
      && ./b2 install link=static \
      && cd /home

RUN apt-get update && apt-get -y install pkg-config libssl-dev libsasl2-dev libpthread-stubs0-dev -y
