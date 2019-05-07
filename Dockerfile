FROM debian:latest
MAINTAINER timzaak <zsy.evan@gmail.com>

# Install packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install openssh-server pwgen \
      build-essential \
      cmake \
      make \
      wget \
      unzip \
      libssl1.0-dev \
      libasl-dev \
      libsasl2-dev \
      pkg-config \
      libsystemd-dev \
      zlib1g-dev \
      flex \
      bison \
      gdb


RUN mkdir -p /var/run/sshd && sed -i "s/.*PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 22
CMD ["/run.sh"]
