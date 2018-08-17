FROM openjdk:8-jdk-alpine

MAINTAINER Nagarajan Shanmugam <nagarajan.shanmugam@imaginea.com>

VOLUME /tmp

#Setting the environment varibles

ENV SPRING_PROFILES_ACTIVE ""

ENV SPRING_DATASOURCE_URL "jdbc:postgresql://127.0.0.1:3306/multi-tenant?currentSchema=my_app"

ENV SPRING_DATASOURCE_PASSWORD ""

ENV SPRING_DATASOURCE_USERNAME ''

ENV FLYWAY_ENABLED 'true'

ENV JAVA_OPTIONS "-Djava.security.egd=file:/dev/./urandom -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:MaxRAMFraction=1 -XshowSettings:vm"

ENV JAVA_APP_JAR "app.jar"

RUN echo -e "http://nl.alpinelinux.org/alpine/v3.5/main\nhttp://nl.alpinelinux.org/alpine/v3.5/community" > /etc/apk/repositories

RUN apk add --no-cache bash

RUN \
  mkdir -p /var/log/multi-tenant

ENV service_name="multi-tenant"

RUN \
    mkdir -p /opt/${service_name}/logs && \
    mkdir -p /var/log/${service_name} && \
    touch /var/log/${service_name}/app.log && \
    touch /var/log/${service_name}/${service_name}-stderr.log

ARG JAR_FILE

ADD ${JAR_FILE} /opt/app.jar

ENTRYPOINT exec java -Djava.security.egd=file:/dev/./urandom $JAVA_OPTS -jar /opt/app.jar
