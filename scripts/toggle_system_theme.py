import os
from datetime import datetime
import fileinput
from contextlib import contextmanager


@contextmanager
def chdir(directory):
    previous_dir = os.getcwd()
    os.chdir(directory)
    try:
        yield
    finally:
        os.chdir(previous_dir)


def toggle_gtk_theme(dark_mode):
    gtk_file = "settings.ini"
    with fileinput.input(gtk_file, inplace=True) as file:
        for line in file:
            if line.startswith("gtk-application-prefer-dark-theme"):
                print(f"gtk-application-prefer-dark-theme={'true' if dark_mode else 'false'}")
            else:
                print(line, end="")


def toggle_alacritty_theme(dark_mode):
    alacritty_file = "alacritty.toml"

    with fileinput.input(alacritty_file, inplace=True) as file:
        for line in file:
            if "# DARK" in line:
                if dark_mode:
                    print(line.lstrip("# ").strip())
                else: 
                    print("# " + line.lstrip("# ").strip()) 
            elif "# LIGHT" in line:
                if dark_mode: 
                    print("# " + line.lstrip("# ").strip()) 
                else: 
                    print(line.lstrip("# ").strip()) 
            else:
                print(line, end="") 


def toggle_theme():
    # Is it after 5PM or before 6AM?
    now = datetime.now()
    dark_mode = now.hour >= 17 or now.hour < 6
    home_path = os.path.expanduser("~")

    # Update GTK theme
    with chdir(os.path.join(home_path, ".config/gtk-3.0")):
        toggle_gtk_theme(dark_mode)

    # Update Alacritty theme
    with chdir(os.path.join(home_path, ".config/alacritty")):
        toggle_alacritty_theme(dark_mode)

    #print(f"Theme toggled to {'dark' if dark_mode else 'light'} mode.")


if __name__ == "__main__":
    toggle_theme()

