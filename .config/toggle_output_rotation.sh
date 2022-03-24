#!/bin/sh

#This script toggles the rotation of a given output between 'normal' and 'left'


#Getting info on the output passed as argument for this script
GET_INFO=$(xrandr --query --verbose | grep "^$1" ) #Grep needs regex or else it can get more lines

#This function echoes the current rotation mode of the output (normal, inverted, left, right). If the monitor is primary, the rotation will be one field further.
current_rotation() {
	retval=''
	if [ $(echo $GET_INFO | cut -d' ' -f3 ) = 'primary' ]; then
		#echo "Is primary"
		retval=$(echo $GET_INFO | cut -d' ' -f6)
	else
		#echo "Is not primary"
		retval=$(echo $GET_INFO | cut -d' ' -f5)
	fi
	echo "$retval"
}


#If the current_rotation is 'normal', changes it to 'left'. If it's not, reverts to 'normal'.
if [ "$(current_rotation)" == "normal" ]; then
	#echo "Current rotation is normal"
	xrandr --output $1 --rotate left --auto 
else  
	#echo "Current rotation is not normal"
	xrandr --output $1 --rotate normal --auto
fi 
