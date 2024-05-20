#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Ffmpeg: Add audio on video
# @raycast.mode compact

# Optional parameters:
# @raycast.icon https://upload.wikimedia.org/wikipedia/commons/thumb/7/76/FFmpeg_icon.svg/1200px-FFmpeg_icon.svg.png
# @raycast.packageName capimichi

# Documentation:
# @raycast.description Add audio on video using ffmpeg.
# @raycast.author Michele Capicchioni

on run argv
    

    try
        set ffmpegPath to do shell script "which ffmpeg"
    on error
        error "You need to install ffmpeg. You can install it using `brew install ffmpeg`"
    end try

    # Use file manager to select video file
    set videoFile to POSIX path of (choose file with prompt "Select video file" of type {"mp4", "mov"})
    
    # check if video file is selected
    if videoFile is "" then
        error "No video file selected"
    end if

    # Use file manager to select audio file
    set audioFile to POSIX path of (choose file with prompt "Select audio file" of type {"mp3", "wav"})

    # check if audio file is selected
    if audioFile is "" then
        error "No audio file selected"
    end if

    # Use file manager to select output file
    set outputFile to POSIX path of (choose file name with prompt "Save output file as" default name "output.mp4" default location (path to desktop) without invisibles)

    # check if output file is selected
    if outputFile is "" then
        error "No output file selected"
    end if

    # Run ffmpeg command ffmpeg -i video.mp4 -i audio.wav -map 0:v -map 1:a -c:v copy -shortest output.mp4
    set command to ffmpegPath & " -i " & quoted form of videoFile & " -i " & quoted form of audioFile & " -map 0:v -map 1:a -c:v copy -shortest " & quoted form of outputFile

end run