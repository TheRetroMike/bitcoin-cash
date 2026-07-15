FROM ubuntu:22.04
RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install build-essential cmake git libboost-chrono-dev libboost-filesystem-dev libboost-test-dev libboost-thread-dev libevent-dev libminiupnpc-dev libnatpmp-dev libssl-dev libzmq3-dev help2man ninja-build python3 libgmp-dev zlib1g-dev libdb-dev libdb++-dev libqrencode-dev qttools5-dev -y

#RUN apt-get install wget build-essential -y
WORKDIR /opt/
RUN git clone https://gitlab.com/bitcoin-cash-node/bitcoin-cash-node.git
WORKDIR /opt/bitcoin-cash-node/
RUN mkdir build
WORKDIR /opt/bitcoin-cash-node/build
RUN cmake -GNinja .. -DBUILD_BITCOIN_QT=OFF
RUN ninja
RUN ninja check
RUN ninja install
#RUN wget https://github.com/bitcoin-cash-node/bitcoin-cash-node/releases/download/v29.0.0/bitcoin-cash-node-29.0.0-x86_64-linux-gnu.tar.gz
#RUN tar zxvf bitcoin-cash-node-29.0.0-x86_64-linux-gnu.tar.gz
#RUN mv bitcoin-cash-node-29.0.0/bin/* /usr/bin/
#RUN wget https://raw.githubusercontent.com/TheRetroMike/rmt-nomp/master/scripts/blocknotify.c
#RUN gcc blocknotify.c -o /usr/bin/blocknotify
CMD /usr/bin/bitcoind -printtoconsole
