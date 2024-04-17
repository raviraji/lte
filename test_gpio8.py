import pulser_gpio as pg
import time
import sys

'''
1 - for LTE reset
2 - aeroplane mode
'''

if int(sys.argv[1]) == 1:
    pg.setup(156, 0, 1)
    time.sleep(0.1)
    pg.output(156, 0)
    time.sleep(5)
    pg.output(156,1)
elif int(sys.argv[1]) == 2:
    pg.setup(5, 0, 1)
    time.sleep(0.1)
    pg.output(5, 0) 
    time.sleep(5)
    pg.output(5,1)
