#!/usr/bin/env python
# coding: utf-8

import subprocess
import glob
import os


files_grabbed = [glob.glob(e) for e in ['*.mp4', '*.mkv', '*.avi']]
flat_list = [item for sublist in files_grabbed for item in sublist]


sublist = {}
for file in flat_list:
    basename = os.path.splitext(file)[0]
    sublist[file] = glob.glob(f"{basename}*srt")


for k, v in sublist.items():
    i = " ".join(v)
    subprocess.run(["ffsubsync", k, "-i", i, "--overwrite-input"])
    #for i in v:
    #    subprocess.run(["ffsubsync", k, "-i", i, "--overwrite-input"])
