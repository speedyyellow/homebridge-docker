FROM debian:jessie
MAINTAINER Christian Brandlehner <christian@brandlehner.at>

RUN apt-get update

##################################################
# Set environment variables                      #
##################################################

# Ensure UTF-8
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8



ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

##################################################
# Install tools                                  #
##################################################

RUN apt-get install -y curl wget git apt-transport-https python build-essential make g++ libavahi-compat-libdnssd-dev libkrb5-dev vim net-tools && \
curl -sL https://deb.nodesource.com/setup_5.x | bash - && \
apt-get install --yes nodejs

RUN alias ll='ls -alG'

##################################################
# Install homebridge                             #
##################################################

RUN npm install -g homebridge

##################################################
# Start                                          #
##################################################

USER root

RUN mkdir -p /var/run/dbus

EXPOSE 5353 51826

ADD install_plugins.sh /root/install_plugins.sh
ADD run.sh /root/run.sh

# as we are using "docker -v" to keep the config outside of the container, the config MUST NOT be in the container
# RUN mkdir /root/.homebridge
# ADD config.json /root/.homebridge/config.json

VOLUME ["/root/.homebridge"]
CMD ["/root/run.sh"]
