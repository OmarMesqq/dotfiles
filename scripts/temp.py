import os

def toggle_redshift_state(file_path="/tmp/rst"):
    redshift_night_cmd = "redshift -P -O 3500"
    redshift_day_cmd = "redshift -P -O 6000"

    if not os.path.exists(file_path):
        with open(file_path, "w") as rst:
            rst.write("night\n")
        os.system(redshift_night_cmd)
    else:
        with open(file_path, "r") as rst:
            last_line = rst.readlines()[-1].strip()

        # Toggle the state
        if last_line == "night":
            new_state = "day"
            os.system(redshift_day_cmd)
        elif last_line == "day":
            new_state = "night"
            os.system(redshift_night_cmd)
        else:
            raise ValueError(f"Unexpected state in {file_path}: {last_line}")

        # Update the file with the new state
        with open(file_path, "w") as rst:
            rst.write(f"{new_state}\n")

toggle_redshift_state()

