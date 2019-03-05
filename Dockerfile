FROM java:openjdk-8-alpine 

LABEL maintainer="Kevin Edwards <kedwards@kevinedwards.ca>"

ENV BUILD_PACKAGES "openrc openssh"

ENV APP_PACKAGES "php5"

RUN apk -v --no-cache --update add \
    $BUILD_PACKAGES \
    $APP_PACKAGES && \
    rc-update add sshd && \
    adduser -S jenkins

EXPOSE 22

CMD ["/usr/sbin/sshd"]