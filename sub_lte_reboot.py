import json
import subprocess
import threading
import time
import re
import yaml
from subprocess import DEVNULL
import os
def subProcess(command):
    p = subprocess.Popen(command, stdout=subprocess.PIPE, shell=True)
    (output, err) = p.communicate()
    p_status = p.wait()
    data = output.decode("utf-8")
    return data
if __name__ == "__main__":
    # To stop the modem manager 
    subProcess("sudo systemctl stop ModemManager")
    time.sleep(2)
    pMmDebug = subprocess.Popen("sudo ModemManager --debug", stdout=DEVNULL, stderr=DEVNULL, shell=True)
    print('waiting for 50 seconds to modem manager boot up...')
    for i in range(5):
        print(".", end="")
        time.sleep(10)
    subProcess("sudo pkill -KILL ModemManager")
    time.sleep(2)
    subProcess("sudo systemctl start ModemManager")
    time.sleep(10)
