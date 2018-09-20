FROM ubuntu:16.04

# Install some dependencies
RUN apt-get update && apt-get install -y build-essential cmake git sudo wget libboost-dev python-pip python-tk libncurses5-dev libncursesw5-dev 
RUN pip install --upgrade pip  
RUN pip install tabulate 
RUN pip install numpy
RUN pip install r2pipe 
RUN pip install benchexec 
RUN python -mpip install matplotlib

# Install llvm 6.0 (based on http://apt.llvm.org/)
RUN echo "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial main" >> /etc/apt/sources.list
RUN echo "deb-src http://apt.llvm.org/xenial/ llvm-toolchain-xenial main"  >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 15CF4D18AF4F7421
#RUN echo "wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|apt-key add -"
# Fingerprint: 6084 F3CF 814B 57C1 CF12 EFD5 15CF 4D18 AF4F 7421"
RUN apt-get update && apt-get install -y pkg-config libllvm6.0 llvm-6.0 llvm-6.0-dev llvm-6.0-doc llvm-6.0-examples llvm-6.0-runtime clang-6.0 clang-tools-6.0 clang-6.0-doc libclang-common-6.0-dev libclang-6.0-dev libclang1-6.0 clang-format-6.0 python-clang-6.0 libc6-dbg gdb

# Add a non-root user
RUN useradd --create-home --shell /bin/bash sip && adduser sip sudo
RUN echo 'sip:sip' | chpasswd
WORKDIR /home/sip

# Pull git repos
####dg
RUN git clone https://github.com/tum-i22/dg.git && \
    mkdir -p /home/sip/dg/build && \
    cmake -H/home/sip/dg -B/home/sip/dg/build && \
    make -C /home/sip/dg/build -j 2 install
####input-dependency library
RUN git clone --depth 1 -b acsac https://github.com/tum-i22/input-dependency-analyzer.git && \
    mkdir -p /home/sip/input-dependency-analyzer/build && \
    cmake -H/home/sip/input-dependency-analyzer -B/home/sip/input-dependency-analyzer/build && \
    make -C /home/sip/input-dependency-analyzer/build install

####Radare2
RUN git clone --depth 1 https://github.com/radare/radare2.git && \
    /home/sip/radare2/sys/install.sh


####self-checksumming
RUN git clone --depth 1 -b acsac https://github.com/tum-i22/self-checksumming.git && \
    mkdir -p /home/sip/self-checksumming/build && \
    cmake -H/home/sip/self-checksumming -B/home/sip/self-checksumming/build && \
    make -C /home/sip/self-checksumming/build && \
    make -C /home/sip/self-checksumming/hook
####oblivious hashing
RUN git clone --depth 1 -b acsac https://github.com/tum-i22/sip-oblivious-hashing.git && \
    mkdir -p /home/sip/sip-oblivious-hashing/build && \
    cmake -H/home/sip/sip-oblivious-hashing -B/home/sip/sip-oblivious-hashing/build && \
    make -C /home/sip/sip-oblivious-hashing/build
####eval
RUN git clone --depth 1 -b acsac https://github.com/mr-ma/sip-eval.git eval && \
    mkdir -p /home/sip/eval/passes/build && \
    cmake -H/home/sip/eval/passes -B/home/sip/eval/passes/build && \
    make -C /home/sip/eval/passes/build
#RUN git clone --depth 1 -b acsac https://github.com/mr-ma/input-dependency-analyzer.git
#WORKDIR /home/sip/input-dependency-analyzer

#RUN git clone --depth 1 -b acsac https://github.com/tum-i22/sip-oblivious-hashing.git
#WORKDIR /home/sip/sip-oblivious-hashing
#WORKDIR /home/sip/sip-oblivious-hashing/input-dependency-analyzer
#RUN mkdir -p /home/sip/sip-oblivious-hashing/input-dependency-analyzer/build
#RUN cmake -H/home/sip/sip-oblivious-hashing/input-dependency-analyzer -B/home/sip/sip-oblivious-hashing/input-dependency-analyzer/build && \
#RUN make -C /home/sip/sip-oblivious-hashing/input-dependency-analyzer/build -j 2 install
#RUN make



# Copy pass files
#COPY files/home/ /home/sip/
#COPY files/include/ /usr/local/include/
#COPY files/lib/ /usr/local/lib/

# Switch to user
RUN chown -R sip:sip .
USER sip

