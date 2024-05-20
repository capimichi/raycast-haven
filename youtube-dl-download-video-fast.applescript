#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Youtube-dl: Download video fast
# @raycast.mode compact

# Optional parameters:
# @raycast.icon https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTowJjFW22_21ogdZ9nauAIrOeNsODULE319wj_6iFeQA&s
# @raycast.packageName capimichi

# Documentation:
# @raycast.description Download video with youtube-dl
# @raycast.author Michele Capicchioni

on run argv
    

    try
        set youtubedl to do shell script "which youtube-dl"
    on error
        error "You need to install youtube-dl, you can install it with brew install youtube-dl"
    end try

    # get pbpaste
    try 
        set pbpaste to do shell script "which pbpaste"
    on error
        error "You need to install pbpaste, you can install it with brew install pbpaste"
    end try

    # get video url
    set video_url to do shell script pbpaste

    # Use file manager to select output file
    set outputFile to POSIX path of (choose file name with prompt "Save output file as" default name "output.mp4" default location (path to downloads folder) without invisibles)

    # check if output file is selected
    if outputFile is "" then
        error "No output file selected"
    end if

    # download video
    do shell script youtubedl & " -o " & quoted form of outputFile & " " & video_url

end run