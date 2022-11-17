#!/bin/sh

# autostart script for qtile

cmd_exist() { unalias "$1" >/dev/null 2>&1 ; command -v "$1" >/dev/null 2>&1 ;}

__kill() { kill -9 "$(pidof "$1")" >/dev/null 2>&1 ; }

__start() { sleep 1 && "$@" >/dev/null 2>&1 & }

__running() { pidof "$1" >/dev/null 2>&1 ;}

start_app() {
    if cmd_exist $1 ; then
        __kill $1
        __start $1
    fi
}

run() {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

# set capslock key to escape
setxkbmap -option caps:escape &

# set natural trackpad scrolling (Razer Blade 15 Advanced)
xinput set-prop 16 303 1 &
xinput set-prop 16 329 1 &


# start_app "picom"
if cmd_exist "picom" ; then
    __kill "picom" &
    #__start picom --experimental-backends &
    __start picom &
fi

#start_app "brave" &
#start_app "alacritty" &
#start_app "discord" &
#start_app "signal-desktop" &
#start_app "nextcloud" &
#start_app "yubioath-desktop" &
#start_app "pavucontrol" &
#start_app "virt-manager" &
#start_app "gwe" &
#start_app "strawberry" &
#start_app "steam" &
#start_app "lutris" &

xscreensaver --no-splash &

libinput-gestures-setup autostart start &

prime-offload
