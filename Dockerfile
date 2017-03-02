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
            python-pip

RUN git clone https://github.com/pycket/pycket
WORKDIR pycket
RUN hg clone https://bitbucket.org/pypy/pypy

ENV INSTALLER=racket-test-current-x86_64-linux-wheezy.sh
RUN wget http://plt.eecs.northwestern.edu/snapshots/current/installers/$INSTALLER
RUN sh $INSTALLER --in-place --dest racket

RUN make setup
RUN make test
