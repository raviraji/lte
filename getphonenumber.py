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
def getOperator(command):
    print(command)
    cmdOut = subProcess(command)
    opOut = ""
    if len(cmdOut) > 0:
        opOut = cmdOut.split(':')[2].split(',')[2]
    return opOut
def getPhoneNumber(command):
    print(command)
    cmdData = subProcess(command)
    apnout = ""
    if len(cmdData) > 0:
        #apnout = cmdData.split(':')[2].split(',')[2]
        apnout = cmdData
    return apnout
if __name__ == "__main__": 
    subProcess("sudo systemctl stop ModemManager")
    time.sleep(2)
    pMmDebug = subprocess.Popen("sudo ModemManager --debug", stdout=DEVNULL, stderr=DEVNULL, shell=True)
    print('waiting for 50 seconds to modem manager boot up...')
    for i in range(5):
        print(".", end="")
        time.sleep(10)
    operatorName = getOperator("sudo mmcli -m 0 --command=\"AT+COPS?\"")
    if len(operatorName) > 0:
        print("Operator name ", operatorName)
    else:
        print("Couldn't read operator name")
    phoneNumber = getPhoneNumber("sudo mmcli -m 0 --command=\"AT+CNUM\"")
    if len(phoneNumber) > 0:
        print("Phone Number ", phoneNumber)
    else:
        print("Couldn't read Phone Number")
    print('waiting for 5 seconds command execution...')
    time.sleep(5)
    subProcess("sudo pkill -KILL ModemManager")
    time.sleep(2)
    subProcess("sudo systemctl start ModemManager")
    time.sleep(10)
