#! /bin/bash 
 
 get_connection_status() { 
 local rt_val=$(curl -I https://www.google.com/ --max-time 5 -s -o /dev/null -w "%{http_code}") 
  echo "http code rtval: ${rt_val}" 
  if [[ "$rt_val" -eq "200" ]] 
  then 
    # return 0 for success 
    return 0 
  fi 
  # return 1 for failure 
  return 1 
} 
 
g_retry_count=0 
g_success_count=0 
while [[ true ]] 
do 
  echo "Entering sleep, retry count = ${g_retry_count}" 
  sleep 30 
  get_connection_status 
  if [[ "$?" -eq "0" ]]; then 
    g_success_count=$((g_success_count+1)) 
    echo "g_success_count: ${g_success_count}" 
  fi 
 
  if [[ "${g_retry_count}" -gt "2" ]]; then 
    break 
  fi 
  g_retry_count=$((g_retry_count+1)) 
done 
if [[ "${g_success_count}" -eq "0"  ]]; then 
  echo "network reboot" 
  sleep 2
sudo reboot
else 
  echo "connection status is good, n_success = ${g_success_count}" 
fi
