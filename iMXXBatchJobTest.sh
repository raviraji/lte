#!/bin/bash
IMXVER = $(lscpu | grep Cortex*)
IMXVER = "${IMXVER:21}"
if [ ${IMXVER} == Cortex-A7 ]
 echo "Downloading & Executing iMX7D file/ script"
 #curl "<link here>" /home/dt/check-lte_new.sh
else
 echo "Downloading & Executing iMX8M file/script"
 #curl "<link here>" /home/dt/check-lte_new.sh
fi

sudo mv check-lte.sh check-lte_backup.sh
sudo mv check-lte_new.sh check-lte.sh
sudo chmod +x filename