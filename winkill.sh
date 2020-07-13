#/bin/bash

if [ "$EUID" -ne 0 ]
then
    echo "Script must be run as privileged user."
    exit
fi

if ! command -v xprop &> /dev/null
then
    echo "xprop command could not be found."
    exit
fi

echo "Waiting for a selection..."

p_pid=`xprop | grep "PID" | cut -d "=" -f2`
p_name=`ps -p $p_pid -o comm=`

echo "Kill target process: "$p_name" (PID:$p_pid)"
read -p "Confirm <y/N>" choice

case "$choice" in 
    y|Y ) sudo kill -9 $p_pid;;
    n|N|"" ) echo "Aborting...";;
    * ) echo "Invalid input. Aborting...";;
esac
