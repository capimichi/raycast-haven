#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title MD to PDF
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📄
# @raycast.packageName capimichi

# Documentation:
# @raycast.description Converts the selected MD file to PDF using Pandoc. It requires Pandoc to be installed, and you can choose the PDF engine to use, but first you need to install it. You can install the PDF engines using Homebrew. For example, to install the `weasyprint` engine, you can run `brew install weasyprint`.
# @raycast.author Michele Capicchioni

# Argument
# @raycast.argument1 { "type": "dropdown", "placeholder": "PDF Engine", "percentEncoded": true, "data": [ { "title": "pdfroff", "value": "pdfroff" }, { "title": "wkhtmltopdf", "value": "wkhtmltopdf" }, { "title": "weasyprint", "value": "weasyprint" }, { "title": "pagedjs-cli", "value": "pagedjs-cli" }, { "title": "prince", "value": "prince" }, { "title": "pdflatex", "value": "pdflatex" }, { "title": "lualatex", "value": "lualatex" }, { "title": "xelatex", "value": "xelatex" }, { "title": "latexmk", "value": "latexmk" }, { "title": "tectonic", "value": "tectonic" }, { "title": "typst", "value": "typst" }, { "title": "context", "value": "context" } ] }

on run argv
    set selectedFile to do shell script "osascript -e 'tell application \"Finder\" to get POSIX path of (item 1 of (get selection) as alias)'"
    set pdfEngine to item 1 of argv
    set outputFilePath to selectedFile & ".pdf"
    
    # Check if the file already exists and delete it if it does
    do shell script "[ -f " & outputFilePath & " ] && rm " & outputFilePath
    
    do shell script "pandoc --pdf-engine=" & pdfEngine & " -o " & outputFilePath & " " & selectedFile
end run