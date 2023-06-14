import os 

x = os.listdir(".")
sup_ext = [".pdf", ".jpg", ".png", ".jpeg"]

for i in x:
    file_ext = os.path.splitext(i)[1]

    for j in sup_ext: 
        if file_ext.lower() == j:
            os.system(f"exiftool -all= {i}")

