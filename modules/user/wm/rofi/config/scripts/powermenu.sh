#!/run/current-system/sw/bin/bash
menu="rofi -dmenu -i -theme ~/.config/rofi/nav.rasi" 
options=("Logout" "Sleep" "Restart" "Shutdown")
options_str=$(printf "%s\n" "${options[@]}")
choice=$(echo -e "$options_str" | $menu -l 4)

are_you_sure() {
  printf "no\nyes" | $menu -l 2| grep -q "^yes$"
}
case "$choice" in
  Shutdown)  
    if are_you_sure; then 
      shutdown now&
    fi
    ;;
  Restart) 
    if are_you_sure; then 
      reboot&
    fi
    ;;
  Logout) 
    if are_you_sure; then 
        if [[ "$1" == "awesome" ]]; then 
          awesome-client "awesome.quit()"&
        fi

        if [[ $1 == "sway" ]]; then
           swaymsg exit 
        fi
    fi
    ;;
  Sleep)
    if are_you_sure; then 
      systemctl suspend&
    fi
    ;;
esac
