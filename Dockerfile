FROM java:openjdk-8-alpine 

LABEL maintainer="Kevin Edwards <kedwards@kevinedwards.ca>"

ARG COMPOSE_VERSION=1.23.2

ENV BUILD_DEPS ""

ENV PACKAGES "openrc openssh docker curl git bash ansible python3 py-pip"
 
RUN apk add --no-cache --virtual=build-dependencies ${BUILD_DEPS} && \
    apk add --no-cache ${PACKAGES} && \
    pip install --upgrade pip && \
    pip install docker-compose && \
    # git clone --branch ${COMPOSE_VERSION} https://github.com/docker/compose.git /code/compose && \
    # cd /code/compose && \
    # pip --no-cache-dir install -r requirements.txt -r requirements-dev.txt pyinstaller==3.1.1 && \
    # git rev-parse --short HEAD > compose/GITSHA && \
    # ln -s /lib /lib64 && ln -s /lib/libc.musl-x86_64.so.1 ldd && ln -s /lib/ld-musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 && \
    # pyinstaller docker-compose.spec && \
    # unlink /lib/ld-linux-x86-64.so.2 /lib64 ldd || true && \
    # mv dist/docker-compose /usr/local/bin/docker-compose && \
    # pip freeze | xargs pip uninstall -y && \
    # rm -rf /code /usr/lib/python2.7/ /root/.cache /var/cache/apk/* && \
    # chmod +x /usr/local/bin/docker-compose && \
    rc-update add sshd && \
    rc-update add docker && \
    adduser -S jenkins && \
    addgroup -S jenkins docker && \
    echo "jenkins:jenkins" | chpasswd

VOLUME /var/lib/docker

EXPOSE 22

CMD ["/usr/sbin/sshd"]