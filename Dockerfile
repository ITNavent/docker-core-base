ARG BASE_IMAGE=adoptopenjdk/openjdk8:jdk8u202-b08-alpine 
FROM golang:1.10.0-alpine
RUN apk add --no-cache git
ENV GOPATH /go
RUN go get -u github.com/googlecloudplatform/gcsfuse

FROM ${BASE_IMAGE}
LABEL maintainer="corerealestate@navent.com"

RUN apk add --no-cache tzdata
ENV TZ America/New_York
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

COPY --from=0 /go/bin/gcsfuse /usr/local/bin

RUN apk add --no-cache ca-certificates fuse && rm -rf /tmp/*

WORKDIR /home/navent/app

ARG NR_VERSION=5.14.0
RUN echo ${NR_VERSION}

RUN apk add --no-cache curl

RUN curl -o newrelic.jar https://repo1.maven.org/maven2/com/newrelic/agent/java/newrelic-agent/${NR_VERSION}/newrelic-agent-${NR_VERSION}.jar

COPY newrelic.yml newrelic.yml

ARG SCUTTLE_VERSION=v1.3.1
RUN echo ${SCUTTLE_VERSION}
RUN curl -L https://github.com/redboxllc/scuttle/releases/download/${SCUTTLE_VERSION}/scuttle-linux-amd64.zip | jar xv
RUN chmod +x scuttle