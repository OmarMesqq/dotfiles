import os

def toggle_gammastep_state(file_path="/tmp/gammastep_state"):
    gammastep_night_cmd = "pkill gammastep; gammastep -O 3500 &"
    gammastep_day_cmd = "pkill gammastep; gammastep -O 6000 &"

    if not os.path.exists(file_path):
        with open(file_path, "w") as state_file:
            state_file.write("night\n")
        os.system(gammastep_night_cmd)
    else:
        with open(file_path, "r") as state_file:
            last_line = state_file.readlines()[-1].strip()

        # Toggle the state
        if last_line == "night":
            new_state = "day"
            os.system(gammastep_day_cmd)
        elif last_line == "day":
            new_state = "night"
            os.system(gammastep_night_cmd)
        else:
            raise ValueError(f"Unexpected state in {file_path}: {last_line}")

        # Update the file with the new state
        with open(file_path, "w") as state_file:
            state_file.write(f"{new_state}\n")

toggle_gammastep_state()

