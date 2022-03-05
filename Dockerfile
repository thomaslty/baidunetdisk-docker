#FROM jlesage/baseimage-gui:debian-10
#FROM beeh1ve/baseimage-gui:debian-10.aarch64
FROM eecs388/baseimage-gui:debian-10

ARG  BAIDUNETDISK_VER=4.3.0

ENV APP_NAME="Baidunetdisk"
ENV DISPLAY_WIDTH="1100"
ENV DISPLAY_HEIGHT="800"

COPY root /
COPY startapp.sh /startapp.sh

RUN apt-get update  \
&& apt-get install -y wget libnss3 libxss1 desktop-file-utils libasound2 ttf-wqy-zenhei libgtk-3-0 libgbm1 libnotify4 xdg-utils libsecret-common libsecret-1-0 libindicator3-7 libdbusmenu-glib4 libdbusmenu-gtk3-4 libappindicator3-1   \
&& wget https://issuepcdn.baidupcs.com/issue/netdisk/LinuxGuanjia/4.3.0/baidunetdisk_4.3.0_arm64.deb \
&& dpkg -i baidunetdisk_4.3.0_arm64.deb \
&& rm baidunetdisk_4.3.0_arm64.deb \
# XDAMAGE is not working well. -noxdamage
&&  sed -i 's@usr\/bin\/x11vnc  \\@usr\/bin\/x11vnc  \\\n                    -noxdamage \\@'   /etc/services.d/x11vnc/run   \
&&  install_app_icon.sh https://github.com/thomaslty/baidunetdisk-docker/raw/master/icon/baidunetdisk.png  \
# fix window decorations
&&  sed -i 's@<decor>no<\/decor>@<decor>yes<\/decor>@g'  /etc/xdg/openbox/rc.xml  \
# fix dpkg
&&  sed -i '/messagebus/d' /var/lib/dpkg/statoverride
