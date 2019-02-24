FROM debian:latest

MAINTAINER Kevin Edwards "<kedwards@kevinedwards.ca>"

RUN apt-get -q update && \
    apt-get upgrade -y && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common openssh-server git openjdk-8-jre-headless && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get -q update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io && \
    apt-get -q autoremove && \
    apt-get -q clean -y && \
	rm -rf /var/lib/apt/lists/* && \
	rm -f /var/cache/apt/*.bin && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
    mkdir -p /var/run/sshd && \
    curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose 

COPY wrapdocker.sh /usr/local/bin/wrapdocker

RUN chmod +x /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/wrapdocker  && \
    useradd -m -d /home/jenkins -s /bin/sh jenkins && \
    echo "jenkins:jenkins" | chpasswd

VOLUME /var/lib/docker

EXPOSE 22

CMD ["wrapdocker"]

