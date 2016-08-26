FROM phusion/baseimage:0.9.15

#########################################
##         RUN INSTALL SCRIPT          ##
#########################################

ADD install.sh /tmp/
RUN chmod +x /tmp/install.sh && /tmp/install.sh && rm /tmp/install.sh

##################################################
# Start                                          #
##################################################

USER root

RUN mkdir -p /var/run/dbus

EXPOSE 5353 51826

ADD install_plugins.sh /root/install_plugins.sh
ADD run.sh /root/run.sh

VOLUME ["/root/.homebridge"]
CMD ["/root/run.sh"]
