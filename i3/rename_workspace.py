#!/usr/bin/python3
import subprocess
import sys
import json

data = sys.stdin.readlines()[0].strip()


test = subprocess.Popen(["i3-msg","-t","get_workspaces"], stdout=subprocess.PIPE)
output = test.communicate()[0]

windows = json.loads(output.decode())
windows = sorted(windows, key=lambda k: k['name']) 

for i in windows:
    if i['focused']:
        window = i['num']

if data:
    test = subprocess.Popen(["i3-msg","rename workspace to \"" + str(window) + ": " + data + "\""], stdout=subprocess.PIPE)
else:
    test = subprocess.Popen(["i3-msg","rename workspace to \"" + data + "\""], stdout=subprocess.PIPE)
