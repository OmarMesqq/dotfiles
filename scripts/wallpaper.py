import os 
import time 

# Puts current hour in a variable 
w = int(time.strftime('%H', time.localtime()))


if w <= 7 or w >=18:
    
    os.system('feh --bg-scale ~/wallpaper/dark.jpg')

else:
    os.system('feh --bg-scale ~/j/wallpaper/bright.jpg')


