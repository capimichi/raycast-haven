#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Rembg: Remove Background
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📄
# @raycast.packageName capimichi

# Documentation:
# @raycast.description Remove the background from an image using Rembg. Rembg should be installed on your system. You can install it using `pip install rembg`.
# @raycast.author Michele Capicchioni

on run argv
    set selectedFile to do shell script "osascript -e 'tell application \"Finder\" to get POSIX path of (item 1 of (get selection) as alias)'"
    set outputFilePath to selectedFile & ".png" # Change the output file format to png
    
    # Check if the file already exists and delete it if it does
    # do shell script "[ -f " & outputFilePath & " ] && rm " & outputFilePath

    set rembgPath to do shell script "which rembg"
    do shell script rembgPath & " i " & selectedFile & " > " & outputFilePath
end run