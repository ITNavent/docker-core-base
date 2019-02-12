ARG BASE_IMAGE=openjdk:8-jre-alpine
#RUN echo ${BASE_IMAGE}

FROM ${BASE_IMAGE}
LABEL maintainer="corerealestate@navent.com"

WORKDIR /home/navent/app

ARG NR_VERSION=4.7.0
RUN echo ${NR_VERSION}

RUN apk add --no-cache curl

RUN curl -o newrelic.jar http://central.maven.org/maven2/com/newrelic/agent/java/newrelic-agent/${NR_VERSION}/newrelic-agent-${NR_VERSION}.jar

COPY newrelic.yml newrelic.yml
