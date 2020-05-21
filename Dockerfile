# daemon runs in the background
# run something like tail /var/log/ThunderbirdCoind/current to see the status
# be sure to run with volumes, ie:
# docker run -v $(pwd)/ThunderbirdCoind:/var/lib/ThunderbirdCoind -v $(pwd)/wallet:/home/ThunderbirdCoin --rm -ti ThunderbirdCoin:0.2.2
ARG base_image_version=0.10.0
FROM phusion/baseimage:$base_image_version

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.2.2/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

ADD https://github.com/just-containers/socklog-overlay/releases/download/v2.1.0-0/socklog-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/socklog-overlay-amd64.tar.gz -C /

ARG ThunderbirdCoin_BRANCH=master
ENV ThunderbirdCoin_BRANCH=${ThunderbirdCoin_BRANCH}

# install build dependencies
# checkout the latest tag
# build and install
RUN apt-get update && \
    apt-get install -y \
      build-essential \
      python-dev \
      gcc-4.9 \
      g++-4.9 \
      git cmake \
      libboost1.58-all-dev && \
    git clone https://github.com/lukasdragon/ThunderbirdCoin.git /src/ThunderbirdCoin && \
    cd /src/ThunderbirdCoin && \
    git checkout $ThunderbirdCoin_BRANCH && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_CXX_FLAGS="-g0 -Os -fPIC -std=gnu++11" .. && \
    make -j$(nproc) && \
    mkdir -p /usr/local/bin && \
    cp src/ThunderbirdCoind /usr/local/bin/ThunderbirdCoind && \
    cp src/walletd /usr/local/bin/walletd && \
    cp src/zedwallet /usr/local/bin/zedwallet && \
    cp src/miner /usr/local/bin/miner && \
    strip /usr/local/bin/ThunderbirdCoind && \
    strip /usr/local/bin/walletd && \
    strip /usr/local/bin/zedwallet && \
    strip /usr/local/bin/miner && \
    cd / && \
    rm -rf /src/ThunderbirdCoin && \
    apt-get remove -y build-essential python-dev gcc-4.9 g++-4.9 git cmake libboost1.58-all-dev && \
    apt-get autoremove -y && \
    apt-get install -y  \
      libboost-system1.58.0 \
      libboost-filesystem1.58.0 \
      libboost-thread1.58.0 \
      libboost-date-time1.58.0 \
      libboost-chrono1.58.0 \
      libboost-regex1.58.0 \
      libboost-serialization1.58.0 \
      libboost-program-options1.58.0 \
      libicu55

# setup the ThunderbirdCoind service
RUN useradd -r -s /usr/sbin/nologin -m -d /var/lib/ThunderbirdCoind ThunderbirdCoind && \
    useradd -s /bin/bash -m -d /home/ThunderbirdCoin ThunderbirdCoin && \
    mkdir -p /etc/services.d/ThunderbirdCoind/log && \
    mkdir -p /var/log/ThunderbirdCoind && \
    echo "#!/usr/bin/execlineb" > /etc/services.d/ThunderbirdCoind/run && \
    echo "fdmove -c 2 1" >> /etc/services.d/ThunderbirdCoind/run && \
    echo "cd /var/lib/ThunderbirdCoind" >> /etc/services.d/ThunderbirdCoind/run && \
    echo "export HOME /var/lib/ThunderbirdCoind" >> /etc/services.d/ThunderbirdCoind/run && \
    echo "s6-setuidgid ThunderbirdCoind /usr/local/bin/ThunderbirdCoind" >> /etc/services.d/ThunderbirdCoind/run && \
    chmod +x /etc/services.d/ThunderbirdCoind/run && \
    chown nobody:nogroup /var/log/ThunderbirdCoind && \
    echo "#!/usr/bin/execlineb" > /etc/services.d/ThunderbirdCoind/log/run && \
    echo "s6-setuidgid nobody" >> /etc/services.d/ThunderbirdCoind/log/run && \
    echo "s6-log -bp -- n20 s1000000 /var/log/ThunderbirdCoind" >> /etc/services.d/ThunderbirdCoind/log/run && \
    chmod +x /etc/services.d/ThunderbirdCoind/log/run && \
    echo "/var/lib/ThunderbirdCoind true ThunderbirdCoind 0644 0755" > /etc/fix-attrs.d/ThunderbirdCoind-home && \
    echo "/home/ThunderbirdCoin true ThunderbirdCoin 0644 0755" > /etc/fix-attrs.d/ThunderbirdCoin-home && \
    echo "/var/log/ThunderbirdCoind true nobody 0644 0755" > /etc/fix-attrs.d/ThunderbirdCoind-logs

VOLUME ["/var/lib/ThunderbirdCoind", "/home/ThunderbirdCoin","/var/log/ThunderbirdCoind"]

ENTRYPOINT ["/init"]
CMD ["/usr/bin/execlineb", "-P", "-c", "emptyenv cd /home/ThunderbirdCoin export HOME /home/ThunderbirdCoin s6-setuidgid ThunderbirdCoin /bin/bash"]
