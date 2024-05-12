#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title PDF separate
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📄
# @raycast.packageName capimichi

# Documentation:
# @raycast.description Split a PDF file into separate pages using the `pdfseparate` command from the `poppler-utils` package.
# @raycast.author Michele Capicchioni

on run argv
    set selectedFile to do shell script "osascript -e 'tell application \"Finder\" to get POSIX path of (item 1 of (get selection) as alias)'"
    set selectedFile to quoted form of selectedFile

    # set output format replacing .pdf with -%d.pdf
    set outputFormat to do shell script "echo " & selectedFile & " | sed 's/\\.pdf/-%d.pdf/'"
    set outputFormat to quoted form of outputFormat

    # split the pdf
    do shell script "pdfseparate " & selectedFile & " " & outputFormat
end run