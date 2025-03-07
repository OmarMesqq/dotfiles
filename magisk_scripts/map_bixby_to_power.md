# My Magisk scripts

`map_bixby_to_power.sh` is a simple shell script remaps the Bixby button (key code `02bf` on my device) in Samsung smartphones 
to do the same as *single pressing the power button* when the device is on i.e. locking the screen/waking it.
This solves a problem I usually have with Samsung devices that involves the
side keys wearing off. This way, I can better "distribute the teardown" between
two buttons instead of one!

You are going to need a device rooted with [Magisk](https://github.com/topjohnwu/Magisk) (or any solution that
allows running scripts as superuser at boot). The keypress event will be captured at low level so you *should* not
be able to remap it in higher abstraction layers (e.g. apps).

## Installation
1. user@computer $: `adb push map_bixby_to_power.sh /sdcard`
2. user@computer $: `adb shell`
3. user@samsung $: `su`
4. root@samsung #: `mv /sdcard/map_bixby_to_power.sh /data/adb/service.d/`
5. root@samsung #: `chmod +x /data/adb/service.d/map_bixby_to_power.sh`

## How it works
The script creates a [named pipe](https://en.wikipedia.org/wiki/Named_pipe) in memory, and
executes [`getevent`](https://source.android.com/docs/core/interaction/input/getevent) on the
special file that represents physical buttons, redirecting its output
to the pipe. This happens in the background in a non-blocking way, and allows the script to continue into an infinite loop.

Inside it, each second, the pipe is checked for its existence and restarts it in case it was killed.
Then, it's queried for new events and performs the necessary logic for
waking/sleeping the screen. This implementation works for daily use, however, some edge cases
like holding Bixby may break the event grabbing logic. Also, I honestly don't know if doing IPC
this way - attempting to get a new event each second is good for battery/performance.

TL,DR: I mean, it has room for improvement, but it works.
