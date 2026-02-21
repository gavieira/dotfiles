#!/bin/bash

# Identificadores extraídos do seu sistema
SINK_HDMI="alsa_output.pci-0000_03_00.1.pro-output-7"
SINK_MCHOSE_NORMAL="alsa_output.usb-C-Media_Electronics_Inc._MCHOSE_V9_PRO_0123456789AB-01.pro-output-0"
SINK_MCHOSE_HEADSET="alsa_output.usb-C-Media_Electronics_Inc._MCHOSE_V9_PRO_HEADSET_0123456789AB-01.analog-stereo"

# Pega o dispositivo padrão atual
CURRENT_SINK=$(pactl get-default-sink)

# Verifica se o Headset está fisicamente conectado/disponível no PipeWire
HEADSET_PLUGADO=$(pactl list short sinks | grep "MCHOSE_V9_PRO_HEADSET")

if [ "$CURRENT_SINK" = "$SINK_HDMI" ]; then
    # Se estou no HDMI e o Headset estiver disponível, ele é a prioridade
    if [ -n "$HEADSET_PLUGADO" ]; then
        pactl set-default-sink "$SINK_MCHOSE_HEADSET"
        notify-send "Áudio" "🎧 Headset MCHOSE Conectado" -i audio-headphones -t 2000
    else
        # Se não tem headset, tenta a saída normal do MCHOSE
        pactl set-default-sink "$SINK_MCHOSE_NORMAL"
        notify-send "Áudio" "🔊 MCHOSE V9 PRO Ativado" -i audio-speakers -t 2000
    fi
else
    # Se eu já estiver em qualquer uma das saídas MCHOSE, volta para o HDMI
    pactl set-default-sink "$SINK_HDMI"
    notify-send "Áudio" "🖥️ Saída HDMI/Monitor Ativada" -i video-display -t 2000
fi
