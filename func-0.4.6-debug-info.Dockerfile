FROM ghcr.io/ton-blockchain/ton:v2025.02

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y -q --no-install-recommends ca-certificates curl wget apt-transport-https gpg git unzip

RUN git clone --recurse-submodules -b func-0.4.6-debug-info --single-branch https://github.com/jefremof/ton.git

RUN apt-get update && apt-get install -y build-essential git cmake ninja-build zlib1g-dev libsecp256k1-dev libmicrohttpd-dev libsodium-dev lsb-release wget software-properties-common gnupg autoconf automake libtool

RUN wget https://apt.llvm.org/llvm.sh && chmod +x llvm.sh && ./llvm.sh 16 all

RUN cd ton && cp ./assembly/native/build-ubuntu-shared.sh . && chmod +x build-ubuntu-shared.sh && ./build-ubuntu-shared.sh && cd ..

ENV TON_PATH=/var/ton-work/db
ENV PATH="${TON_PATH}/ton/build/crypto:${PATH}"