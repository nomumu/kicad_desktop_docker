#!/bin/bash

if [ ! -e ~/.vnc ]; then
    mkdir -p ~/.vnc
    ln -s /usr/share/novnc/download ~/to_download
echo -e "#!/bin/sh\n\n" \
    "unset SESSION_MANAGER\n" \
    "unset DBUS_SESSION_BUS_ADDRESS\n\n" \
    "export DISPLAY=:0\n" \
    "export XDG_SESSION_TYPE=x11\n\n" \
    "[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup\n" \
    "[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources\n" \
    "xsetroot -solid grey\n" \
    "vncconfig -iconic &\n" \
    "xterm -geometry 80x24+10+10 -ls -title \"KiCad Desktop\" &\n" \
    "ulimit -c 0\n\n" \
    "export LANGUAGE=\"ja_JP.UTF-8\"\n" \
    "export LANG=\$LANGUAGE\n" \
    "export XKL_XMODMAP_DISABLE=1\n" \
    "export XDG_CURRENT_DESKTOP=\"GNOME-Flashback:Unity\"\n" \
    "export XDG_MENU_PREFIX=\"gnome-flashback-\"\n" \
    "export QT_IM_MODULE=\"ibus\"\n" \
    "export XMODIFIERS=@im=\"ibus\"\n" \
    "export GTK_IM_MODULE=\"ibus\"\n\n" \
    "dbus-launch gsettings set org.gnome.desktop.input-sources sources \"[('xkb', 'jp'),('ibus', 'mozc-jp')]\"\n" \
    "dbus-launch gsettings set org.gnome.desktop.interface cursor-theme \"DMZ-White\"\n" \
    "dbus-launch gsettings set org.gnome.desktop.screensaver lock-enabled \"false\"\n" \
    "dbus-launch gnome-session --session=gnome-flashback-metacity --disable-acceleration-check --debug &\n" \
    "gnome-terminal &\n" \
    "LANG=setup xdg-user-dirs-update &" > ~/.vnc/xstartup
fi

/etc/init.d/dbus start --user
vncserver :0 -geometry 1440x900 -SecurityTypes None --I-KNOW-THIS-IS-INSECURE -IdleTimeout 3000
websockify --web=/usr/share/novnc/ 15900 localhost:5900
