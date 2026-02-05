#!/bin/bash

# Nomes curtos baseados no seu pactl list
SINK_HDMI="alsa_output.pci-0000_03_00.1.pro-output-7"
SINK_MCHOSE="alsa_output.usb-C-Media_Electronics_Inc._MCHOSE_V9_PRO_0123456789AB-01.pro-output-0"

# Pega o dispositivo padrão atual
CURRENT_SINK=$(pactl get-default-sink)

if [ "$CURRENT_SINK" = "$SINK_MCHOSE" ]; then
    pactl set-default-sink "$SINK_HDMI"
    notify-send "Áudio" "Saída alterada para: HDMI/DisplayPort" -i audio-speakers
else
    pactl set-default-sink "$SINK_MCHOSE"
    notify-send "Áudio" "Saída alterada para: MCHOSE V9 PRO" -i audio-headphones
fi
