#!/bin/bash

# 1. Obtém o layout atual (dwindle ou master)
LAYOUT=$(hyprctl getoption general:layout | grep "str:" | awk '{print $2}' | tr -d '"')

# 2. Verifica se a janela atual faz parte de um grupo (Stack)
IS_GROUP=$(hyprctl activewindow -j | jq '.grouped | length > 0')

# LÓGICA DE CICLO:
# Dwindle -> Master -> Stack (Group) -> volta para Dwindle

if [ "$IS_GROUP" == "true" ]; then
    # Se está em grupo, desfaz o grupo e volta para Dwindle
    hyprctl dispatch togglegroup
    hyprctl keyword general:layout "dwindle"
    notify-send -t 800 "Layout: DWINDLE" -i dialog-information
elif [ "$LAYOUT" == "dwindle" ]; then
    # Se está em Dwindle, muda para Master
    hyprctl keyword general:layout "master"
    notify-send -t 800 "Layout: MASTER" -i dialog-information
else
    # Se está em Master, transforma em Stack (Group)
    hyprctl dispatch togglegroup
    notify-send -t 800 "Layout: STACKED" -i dialog-information
fi
