#!/usr/bin/env bash
rofi_command="rofi -no-fixed-num-lines"

uptime=$(uptime -p | sed -e 's/up //g')


if [[ "$layout" == "TRUE" ]]; then
	shutdown="   Shutdown"
	reboot="   Restart"
	lock="󰌾  Lock"
	suspend="󰤄  Sleep"
	logout="󰗽  Logout"
else
    shutdown="   Shutdown"
	reboot="   Restart"
	lock="󰌾  Lock"
	suspend="󰤄  Sleep"
	logout="󰗽  Logout"
fi
ddir="$HOME/.config/rofi/config"

rdialog () {
rofi -dmenu -i -no-fixed-num-lines -p "Are You Sure? " 
}

options="$shutdown\n$reboot\n$suspend\n$logout\n$lock"

chosen="$(echo -e "$options" | $rofi_command -p "UP - $uptime" -dmenu -selected-row 0)"
case $chosen in
    $shutdown)
		ans=$(rdialog &)
		if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
			systemctl poweroff
		elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
			exit
        else
			show_msg
        fi
        ;;
    $reboot)
		ans=$(rdialog &)
		if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
			systemctl reboot
		elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
			exit
        else
			show_msg
        fi
        ;;
    $lock)
        i3lock-fancy
        ;;
    $suspend)
		ans=$(rdialog &)
		if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
			mpc -q pause
			amixer set Master mute
			sh $HOME/.local/bin/lock
			systemctl suspend
		elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
			exit
        else
			show_msg
        fi
        ;;
    $logout)
		ans=$(rdialog &)
		if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
			i3-msg exit
		elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
			exit
        else
			show_msg
        fi
        ;;
esac
