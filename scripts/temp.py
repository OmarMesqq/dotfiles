import os 

# Checks the existence of the redshift tracker (rst) file on RAM 
if not os.path.exists("/tmp/rst"):
    os.system("touch /tmp/rst")

    with open("/tmp/rst", "w") as rst:
        rst.write("night\n")
    
    os.system("redshift -P -O 3500")

else:
    with open("/tmp/rst","r") as rst:
        for line in rst:
            pass

        last_line = line

    if last_line == "night\n":
        os.system("redshift -P -O 6000")
        
        with open("/tmp/rst", "w") as rst:
            rst.write("day\n")
    
    elif last_line == "day\n":
        os.system("redshift -P -O 3500")
        
        with open("/tmp/rst", "w") as rst:
            rst.write("night\n")
        