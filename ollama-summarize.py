#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Ollama Summarize
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 📄
# @raycast.packageName capimichi

# Documentation:
# @raycast.description Summarize the content of the clipboard using Ollama.
# @raycast.author Michele Capicchioni

import subprocess
import urllib.request
import json

def main():
    # check if pbpaste is available
    try:
        subprocess.run(["pbpaste"], check=True)
    except subprocess.CalledProcessError:
        print("Error: pbpaste is not available")
        return

    # get the content of the clipboard
    content = subprocess.run(["pbpaste"], capture_output=True, text=True).stdout.strip()

    # check if the content is empty
    if not content:
        print("Error: the clipboard is empty")
        return

    # check if ollama is running on http://localhost:11434
    try:
        subprocess.run(["curl", "-s", "http://localhost:11434"])
    except subprocess.CalledProcessError:
        print("Error: Ollama is not running on http://localhost:11434")
        return

    # summarize the content using ollama

    prompt = "Summarize the following content:\n\n-----\n\n" + content + "\n\n"

    encoded_json_payload = json.dumps({
        "model": "llama3:8b",
        "prompt": prompt,
        "stream": False
    }).encode('utf-8')

    # send the summarized content to ollama
    try:
        response = subprocess.run(["curl", "-s", "-X", "POST", "-H", "Content-Type: application/json", "-d", encoded_json_payload, "http://localhost:11434/api/generate"], capture_output=True, text=True)
        response_data = json.loads(response.stdout)
        summarized_content = response_data["response"]
        print("\n\n\n\n")
        print("-----")
        print("Summarized content:")
        print("-----")
        print(summarized_content)
    except subprocess.CalledProcessError:
        print("Error: Failed to summarize the content using Ollama")

if __name__ == "__main__":
    main()