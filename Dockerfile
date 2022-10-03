FROM ubuntu:20.04

LABEL org.opencontainers.image.authors="https://github.com/bwbohl"
LABEL org.opencontainers.image.source="https://github.com/bwbohl/docker-mei"
LABEL org.opencontainers.image.revision="v0.1.2"
LABEL maintainer="Johannes Kepper"
LABEL maintainer="Benjamin W. Bohl"
LABEL maintainer="Dennis Ried"

ENV ANT_VERSION=1.10.12
ENV SAXON_VERSION=Saxon-HE/10/Java/SaxonHE10-8J

USER root

# install jre8, unzip
RUN apt-get update && apt-get install -y \
    openjdk-8-jre-headless \
    unzip \
    git && \
    apt-get clean

# setup ant
#ADD https://downloads.apache.org/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz /tmp/ant.tar.gz
#RUN tar -xvf /tmp/ant.tar.gz -C /opt
ENV ANT_HOME=/opt/apache-ant-${ANT_VERSION}
ENV PATH=${PATH}:${ANT_HOME}/bin

# setup saxon
#ADD https://sourceforge.net/projects/saxon/files/${SAXON_VERSION}.zip/download /tmp/saxon.zip

#RUN unzip /tmp/saxon.zip -d ${ANT_HOME}/lib

#setup xerces
#ADD https://www.oxygenxml.com/maven/com/oxygenxml/oxygen-patched-xerces/23.1.0.0/oxygen-patched-xerces-23.1.0.0.jar ${ANT_HOME}/lib

# setup xmlcalabash
#ADD https://github.com/ndw/xmlcalabash1/releases/download/1.3.2-100/xmlcalabash-1.3.2-100.zip /tmp/xmlcalabash.zip
#RUN unzip -q /tmp/xmlcalabash.zip -d /tmp/lib/ && \
#    cp /tmp/lib/*/lib/** ${ANT_HOME}/lib/ && \
#    cp /tmp/lib/*/xmlcalabas*.jar ${ANT_HOME}/lib/


ENV PRINCE_VERSION=14.3-1
ENV PRINCE_BUILD=22.04
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin

ADD https://www.princexml.com/download/prince_${PRINCE_VERSION}_ubuntu${PRINCE_BUILD}_amd64.deb /tmp/

RUN apt-get install -y --no-install-recommends gdebi fonts-stix libc6
RUN    gdebi --non-interactive /tmp/prince_${PRINCE_VERSION}_ubuntu${PRINCE_BUILD}_amd64.deb
RUN    apt-get autoremove -y
RUN    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC set -x \
#    && apt-get update \
#    &&