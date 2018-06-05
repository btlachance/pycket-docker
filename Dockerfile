FROM debian:jessie
MAINTAINER Brian Lachance <blachance@gmail.com>

ADD sources.list /etc/apt/sources.list

ENV PATH=./racket/bin:$PATH
RUN apt-get update && \
    apt-get build-dep -y pypy && \
    apt-get install -y --no-install-recommends \
            ca-certificates \
            libexpat1 \
            libffi6 \
            libgdbm3 \
            libsqlite3-0 \
            git \
            mercurial \
            wget \
            bzip2 \
            pypy \
            python-pip \
            python-yaml \
            python-scipy \
            ghostscript \
            r-base \
            r-cran-reshape2 \
            r-cran-plyr \
            r-cran-boot \
            r-cran-hmisc \
            r-cran-ggplot2 \
            r-cran-devtools \
            r-cran-dplyr \
            r-cran-curl

ENV RACKETV 6.6
ENV RACKETINSTALLER racket-$RACKETV-x86_64-linux.sh
RUN wget -q https://mirror.racket-lang.org/installers/$RACKETV/$RACKETINSTALLER
RUN /bin/bash $RACKETINSTALLER --unix-style --dest /usr

RUN git clone https://github.com/pycket/pycket
WORKDIR pycket
RUN git checkout -q 3573fd1
RUN hg clone -r 7c64684c80f4 https://bitbucket.org/pypy/pypy
RUN raco pkg install -t dir pycket/pycket-lang/

RUN make pycket-c
RUN git clone https://github.com/pycket/pycket-bench ../pycket-bench
WORKDIR ../pycket-bench
RUN rm -r pycket && ln -s ../pycket/ && pip install ReBench

CMD ["rebench", "-d", "-v", "rebench.conf", "FastBenchmark"]