ARG BASE_IMAGE=openjdk:8-jre-alpine
RUN echo ${BASE_IMAGE}

FROM ${BASE_IMAGE}
LABEL maintainer="corerealestate@navent.com"

WORKDIR /home/navent/app

ARG NR_VERSION
RUN echo ${NR_VERSION}

RUN apk add --no-cache curl

RUN curl -o newrelic.jar http://central.maven.org/maven2/com/newrelic/agent/java/newrelic-api/${NR_VERSION}/newrelic-api-${NR_VERSION}.jar

COPY newrelic.yml newrelic.yml