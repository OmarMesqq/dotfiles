import os
import subprocess
import shlex

STATE_FILE = "/tmp/gammastep_state"
GAMMASTEP_NIGHT = "gammastep -P -O 3500"
GAMMASTEP_DAY = "gammastep -P -O 6500"

def run(cmd):
    cmds = shlex.split(cmd)
    return subprocess.Popen(cmds, start_new_session=True)


def kill():
    return subprocess.call("killall gammastep", shell=True)


def toggle_gammastep():
    if not os.path.exists(STATE_FILE):
        state = "night"
        kill()
        run(GAMMASTEP_NIGHT)
    else:
        with open(STATE_FILE, "r") as f:
            state = f.read().strip()

        if state == "night":
            state = "day"
            kill()
            run(GAMMASTEP_DAY)
        else:
            state = "night"
            kill()
            run(GAMMASTEP_NIGHT)

    with open(STATE_FILE, "w") as f:
        f.write(state)


if __name__ == "__main__":
    toggle_gammastep()
