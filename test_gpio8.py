import pulser_gpio as pg 

import time 

 

pg.setup(156, 0, 1) 

time.sleep(0.1) 

pg.output(156, 0) 

time.sleep(5) 

pg.output(156,1) 
