import os

STATE_FILE = "/tmp/redshift_state"
REDSHIFT_NIGHT = "redshift -P -O 3500"
REDSHIFT_DAY = "redshift -P -O 6000"

def toggle_redshift():
    if not os.path.exists(STATE_FILE):
        state = "night"
        os.system(REDSHIFT_NIGHT)
    else:
        with open(STATE_FILE, "r") as f:
            state = f.read().strip()

        if state == "night":
            state = "day"
            os.system(REDSHIFT_DAY)
        else:
            state = "night"
            os.system(REDSHIFT_NIGHT)

    with open(STATE_FILE, "w") as f:
        f.write(state)

if __name__ == "__main__":
    toggle_redshift()
