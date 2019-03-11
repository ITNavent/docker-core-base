ARG BASE_IMAGE
FROM ${BASE_IMAGE}
LABEL maintainer="corerealestate@navent.com"

RUN apk add --no-cache tzdata
ENV TZ America/New_York
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /home/navent/app

ARG NR_VERSION=4.7.0
RUN echo ${NR_VERSION}

RUN apk add --no-cache curl

RUN curl -o newrelic.jar http://central.maven.org/maven2/com/newrelic/agent/java/newrelic-agent/${NR_VERSION}/newrelic-agent-${NR_VERSION}.jar

COPY newrelic.yml newrelic.yml