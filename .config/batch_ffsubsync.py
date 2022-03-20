#!/usr/bin/env python
# coding: utf-8

import subprocess
import glob
import os
import shlex


files_grabbed = [glob.glob(e) for e in ['*.mp4', '*.mkv', '*.avi']]
flat_list = [item for sublist in files_grabbed for item in sublist]


sublist = {}
for file in flat_list:
    basename = os.path.splitext(file)[0]
    sublist[file] = glob.glob(f"{basename}*srt")


for video, subtitles in sublist.items():
    video = shlex.quote(video)
    subs = " ".join(shlex.quote(sub) for sub in subtitles) #Adding quotes to subtitle files and joining them into a single string
    command = f"ffsubsync {video} -i {subs} --overwrite-input"
    print(command)
    subprocess.run(command, shell=True)
