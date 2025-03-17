#!/run/current-system/sw/bin/bash
menu="rofi -dmenu -i -l 4 -theme ~/.config/rofi/nav.rasi" 
options=("Logout" "Sleep" "Restart" "Shutdown")
options_str=$(printf "%s\n" "${options[@]}")
choice=$(echo -e "$options_str" | $menu)

are_you_sure() {
  printf "no\nyes" | $menu | grep -q "^yes$"
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
      awesome-client "awesome.quit()"&
    fi
    ;;
  Sleep)
    if are_you_sure; then 
      systemctl suspend&
    fi
    ;;
esac
