#!/usr/bin/bash
rofic="rofi -no-fixed-num-lines"

upt=$(uptime -p|sed -e 's/up //g')

if [[ "$layout" == "TRUE" ]]; then
	st="   Shutdown"
	rb="   Restart"
	lk="󰌾  Lock"
	ss="󰤄  Sleep"
	lg="󰗽  Logout"
else
    st="   Shutdown"
	rb="   Restart"
	lk="󰌾  Lock"
	ss="󰤄  Sleep"
	lg="󰗽  Logout"
fi

log() 
{
    rofi -dmenu -i -no-fixed-num-lines -p "Are You Sure? "
}

opt="$st\n$rb\n$ss\n$lg\n$lk"

cs="$(echo -e "$opt"| $rofic -p "UP - $upt" -dmenu -selected-row 0)"

show_err()
{
    rofi -dmenu -i -no-fixed-num-lines -p "No: y / n "
}

case $cs in
    $st)
		ans=$(log&)
		if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
			systemctl poweroff
		elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
			exit
        else
			show_err
        fi
        ;;
    $rb)
		ans=$(log&)
		if [[$ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
			systemctl reboot
		elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
			exit
        else
			show_err
        fi
        ;;
    $lk)
        i3lock-fancy
        ;;
    $ss)
		ans=$(log&)
		if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
			mpc -q pause
			amixer set Master mute
			sh $HOME/.local/bin/lock
			systemctl suspend
		elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
			exit
        else
			show_err
        fi
        ;;
    $lg)
		ans=$(log&)
		if [[ $ans == "yes" ]] || [[ $ans == "YES" ]] || [[ $ans == "y" ]]; then
			i3-msg exit
		elif [[ $ans == "no" ]] || [[ $ans == "NO" ]] || [[ $ans == "n" ]]; then
			exit
        else
			show_err
        fi
        ;;
esac
