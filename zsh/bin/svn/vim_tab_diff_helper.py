#!/usr/bin/python
# http://stackoverflow.com/questions/9084936/using-svn-diff-in-combination-with-vimdiff-to-get-tabbed-diff-page-per-modified

import os
import subprocess
import sys

def vim_send(command):
  global vim_server
  subprocess.call(['vim', '--servername', vim_server, '--remote-send',
    command + '<Return>'])

vim_server = os.environ['VIM_SERVERNAME']
svn_orig_file = sys.argv[ len(sys.argv) - 2 ]
modified_file = sys.argv[ len(sys.argv) - 1 ]

vim_send(":tabnew")
vim_send(":e " + svn_orig_file)
vim_send(":diffsplit " + modified_file)
