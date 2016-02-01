#!/bin/bash

rm /var/run/dbus/pid #incase shutdown abruptly

sed -i "s/rlimit-nproc=3/#rlimit-nproc=3/" /etc/avahi/avahi-daemon.conf

dbus-daemon --system
avahi-daemon -D

bash /root/install_plugins.sh /root/.homebridge/pluginsInstallList
mv /root/.homebridge/pluginsInstallList /root/.homebridge/pluginsInstallList.done

homebridge