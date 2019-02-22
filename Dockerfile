FROM debian:latest

MAINTAINER Kevin Edwards "<kedwards@kevinedwards.ca>"

RUN apt-get -q update && \
    apt-get install -y openssh-server git openjdk-8-jre-headless && \
    apt-get -q autoremove && \
    apt-get -q clean -y && \
	rm -rf /var/lib/apt/lists/* && \
	rm -f /var/cache/apt/*.bin && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
    mkdir -p /var/run/sshd

RUN useradd -m -d /home/jenkins -s /bin/sh jenkins && \
    echo "jenkins:jenkins" | chpasswd

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
