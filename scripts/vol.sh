volumeAdjust="amixer -M -q -c 0 sset 'Headset',1 3%"
function getCurrent {
    amixer -M -c 0 sget 'Headset',1 |\
    awk '/Front Left:/ {print $5}' |\
    sd '[\[%\]]' ''
}

if [[ "$1" == "up" ]]; then
    ${volumeAdjust}+
elif [[ "$1" == "down" ]]; then
    ${volumeAdjust}-
fi

getCurrent
