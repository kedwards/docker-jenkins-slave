FROM java:openjdk-8-alpine 

LABEL maintainer="Kevin Edwards <kedwards@kevinedwards.ca>"

ENV BUILD_PACKAGES "openrc openssh docker"

ENV APP_PACKAGES "openjdk8"

RUN apk -v --no-cache --update add \
    $BUILD_PACKAGES \
    $APP_PACKAGES && \
    rc-update add sshd && \
    rc-update add docker && \
    adduser -S jenkins && \
    addgroup -S jenkins docker && \
    echo "jenkins:jenkins" | chpasswd

EXPOSE 22

CMD ["/usr/sbin/sshd"]
