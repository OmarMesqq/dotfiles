# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

from __future__ import (absolute_import, division, print_function)
import os
from ranger.api.commands import Command


class quit_with_directory(Command):
    """
    Exit ranger and cd into the last seen directory
    """
    def execute(self):
        with open('/tmp/rangerdir', 'w') as f:
            f.write(self.fm.thisdir.path)
        self.fm.exit()

