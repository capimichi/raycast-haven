#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Magento 2 REST API
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Search" }
# @raycast.packageName test

# Documentation:
# @raycast.description Test
# @raycast.author Capimichi
# @raycast.authorURL https://github.com/capimichi

import sys
import urllib.request
import json

search = sys.argv[1]

# download https://raw.githubusercontent.com/Strategery-Inc/magento2-swagger-definitions/master/commerce/2.4.0/admin/c240-admin-all.json
url = 'https://raw.githubusercontent.com/Strategery-Inc/magento2-swagger-definitions/master/commerce/2.4.0/admin/c240-admin-all.json'
with urllib.request.urlopen(url) as response:
    if response.getcode() == 200:
        data = json.loads(response.read())
        # search data['paths'] matching search
        for path in data['paths']:
            if search in path:
                path_data = data['paths'][path]
                for method in path_data:
                    print(method, path)
    else:
        print('Failed to download the JSON file.')