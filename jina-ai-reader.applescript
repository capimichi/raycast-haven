#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Jina AI reader
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📄
# @raycast.packageName capimichi

# Documentation:
# @raycast.description Open the url with Jina AI reader.
# @raycast.author Michele Capicchioni

on run argv
    try
        set pbpastePath to do shell script "which pbpaste"
    on error
        error "The pbpaste command is not available on your system."
    end try

    set theURL to do shell script "pbpaste"
    if theURL does not start with "http://" and theURL does not start with "https://" then
        error "The clipboard does not contain a valid URL."
    end if
    do shell script "open 'https://r.jina.ai/" & theURL & "'"
end run