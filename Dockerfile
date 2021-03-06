FROM phusion/baseimage:0.9.15

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################

# Set correct environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV HOME            /root
ENV LC_ALL          C.UTF-8
ENV LANG            en_US.UTF-8
ENV LANGUAGE        en_US.UTF-8
ENV PATH 						$PATH

#########################################
##         RUN INSTALL SCRIPT          ##
#########################################

ADD install.sh /tmp/
RUN chmod +x /tmp/install.sh
RUN /tmp/install.sh 
RUN rm /tmp/install.sh

ADD install_ffmpeg_ubuntu.sh /tmp/
RUN chmod +x /tmp/install_ffmpeg_ubuntu.sh
RUN /tmp/install_ffmpeg_ubuntu.sh 
RUN rm /tmp/install_ffmpeg_ubuntu.sh


##################################################
# Start                                          #
##################################################

USER root

EXPOSE 5353 51826

ADD install_plugins.sh /root/install_plugins.sh
ADD run.sh /root/run.sh

VOLUME ["/root/.homebridge"]
CMD ["/root/run.sh"]
