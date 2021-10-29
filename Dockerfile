FROM ubuntu:focal
LABEL maintainer="nomumu <nomumu-github@koso2-dan.ddo.jp>"

COPY setup_vgl.sh /tmp/setup_vgl.sh
COPY entry.sh /tmp/entry.sh

RUN apt-get update -y && apt-get install -y apt-utils
RUN apt-get update -y && apt-get install -y tzdata
ENV TZ=Asia/Tokyo \
    DISPLAY=:0 \
    LANGUAGE=ja_JP.UTF-8 \
    LC_ALLE=ja_JP.UTF-8 \
    DEBIAN_FRONTEND=noninteractive
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y && apt-get install -y --no-install-recommends ubuntu-gnome-desktop \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN apt-get update -y && apt-get install -y gnome-characters gnome-calculator gnome-shell-extension-desktop-icons gnome-font-viewer xfonts-scalable gedit vim xcursor-themes fonts-ubuntu nautilus-extension-gnome-terminal gir1.2-freedesktop gir1.2-gnomedesktop-3.0 gnome-shell-extensions gnome-themes-standard gnome-session-flashback gnome-shell-extension-prefs libegl1-mesa nautilus sudo wget gpg-agent \
    websockify tigervnc-standalone-server openssh-server \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN wget -q https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -O- | apt-key add - \
    && wget -q https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -O- | apt-key add - \
    && wget https://www.ubuntulinux.jp/sources.list.d/focal.list -O /etc/apt/sources.list.d/ubuntu-ja.list \
    && apt-get update -y && apt-get install -y ubuntu-defaults-ja \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN apt-get update -y && apt-get install -y git cmake gettext expect ibus-gtk ibus-gtk3 firefox

RUN cd /tmp \
    && wget https://sourceforge.net/projects/virtualgl/files/2.6.5/virtualgl_2.6.5_amd64.deb \
    && dpkg -i virtualgl_2.6.5_amd64.deb \
    && rm virtualgl_2.6.5_amd64.deb

RUN add-apt-repository -y ppa:kicad/kicad-5.1-releases \
    && apt-get update -y \
    && apt-get install -y kicad kicad-doc-ja kicad-demos \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN cd /usr/share/ \
    && git clone -b 5.1 https://github.com/KiCad/kicad-i18n.git \
    && cd kicad-i18n && mkdir build && cd build \
    && cmake .. && make install
RUN cd /usr/share \
    && git clone https://github.com/novnc/noVNC.git novnc \
    && cd novnc && git checkout 463c39e4af98ec4106b87bbea17e1605aa4c6180

#UI settings
RUN sed -i -e 's/<option value="remote">/<option value="remote" selected>/g' /usr/share/novnc/vnc.html
RUN sed -i -e 's/Exec=kicad/Exec=vglrun kicad/g' /usr/share/applications/kicad.desktop
RUN sed -i -e 's/Exec=pcbnew/Exec=vglrun pcbnew/g' /usr/share/applications/pcbnew.desktop
RUN sed -i -e 's/Exec=pcb_calculator/Exec=vglrun pcb_calculator/g' /usr/share/applications/pcbcalculator.desktop
RUN sed -i -e 's/Exec=gerbview/Exec=vglrun gerbview/g' /usr/share/applications/gerbview.desktop
RUN sed -i -e 's/Exec=bitmap2component/Exec=vglrun bitmap2component/g' /usr/share/applications/bitmap2component.desktop
RUN sed -i -e 's/Exec=eeshema/Exec=vglrun eeshema/g' /usr/share/applications/eeschema.desktop
RUN sed -i -e 's|<layout>default</layout>|<layout>jp</layout>|g' /usr/share/ibus/component/mozc.xml
RUN mkdir -p /tmp/.X11-unix && chmod 1777 /tmp/.X11-unix

RUN /tmp/setup_vgl.sh
ENTRYPOINT ["/tmp/entry.sh"]

