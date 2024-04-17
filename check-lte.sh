#! /bin/bash
 
get_connection_status() {
 local rt_val=$(curl -I https://www.google.com/ --max-time 5 -s -o /dev/null -w "%{http_code}")
#   echo "http code rtval: ${rt_val}"
 
  if [[ "$rt_val" -eq "200" ]]
  then
    # return 0 for success
    return 0
  fi
 
  # return 1 for failure
  return 1
}
 
sleep 300 # 5 minutes
 
pl=0
retry_counter=3
 
while [[ true ]]
do
    sleep 20 # 20 seconds
    get_connection_status
    if [[ "$?" -eq "0" ]]; then
        echo "connection is good"
        retry_counter=3
        pl=0
    else
        retry_counter=$((retry_counter-1))
        if [[ "${retry_counter}" -eq "0" ]]; then
            echo "retry_counter: ${retry_counter}, pl: ${pl}"
            if [[ "${pl}" -eq "0" ]]; then
                echo "airplane mode"
                sleep 20
                /usr/bin/python3 /home/dt/test_gpio.py 2
                pl=$((pl+1))
                retry_counter=3
            elif [[ "${pl}" -eq "1" ]]; then
                echo "reset LTE module"
                sleep 20
                /usr/bin/python3 /home/dt/test_gpio.py 1
                pl=$((pl+1))
                retry_counter=3
            else
                echo "rebooting the device"
                break
            fi
        fi
 
    fi
done
 
# echo "sudo reboot"
sudo reboot
