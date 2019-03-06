FROM java:openjdk-8-alpine 

LABEL maintainer="Kevin Edwards <kedwards@kevinedwards.ca>"

ENV BUILD_PACKAGES "openrc openssh bash git iptables ca-certificates e2fsprogs docker"

ENV APP_PACKAGES "ruby"

RUN apk -v --no-cache --update add \
    $BUILD_PACKAGES \
    $APP_PACKAGES && \
    rc-update add sshd boot && \
    rc-update add docker boot && \
    adduser -S jenkins -h /home/jenkins -s /bin/sh -G docker && \
    echo "jenkins:jenkins" | chpasswd

VOLUME /var/lib/docker

EXPOSE 22

RUN mv /usr/sbin/sshd /usr/sbin/sshd_real

ADD ./wrapdocker /usr/sbin/sshd

RUN chmod +x /usr/sbin/sshd

CMD ["/usr/sbin/sshd"]
