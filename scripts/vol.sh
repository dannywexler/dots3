cardNumber=1
adjustAmount=3
volumeAdjust="amixer -M -q -c $cardNumber sset 'Headset',1 ${adjustAmount}%"

if [[ "$1" == "up" ]]; then
    ${volumeAdjust}+
    pkill -SIGRTMIN+8 waybar
elif [[ "$1" == "down" ]]; then
    ${volumeAdjust}-
    pkill -SIGRTMIN+8 waybar
elif [[ "$1" == "status" ]]; then
    amixer -M -c $cardNumber sget 'Headset',1 |\
    awk '/Front Left:/ {print $5}' |\
    sd '[\[%\]]' ''
fi
