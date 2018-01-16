#!/bin/bash

# Gets all GW2 material item IDs. This script parses the wiki page for Crafting materials to get all materials listed there,
# then going to the wiki page of each material to get the specific ID. This involves heavy usage of grep, regex and sed, which
# are explained here:
# 1. Retrieve the materials wiki page
# 2. Extract all links from it (all tags starting with "<a href=")
# 3. Remove the "<a href=" part
# 4. Remove the double quotes surrounding the link URL
# 5. Only grab those links that are wiki pages (links starting with "/wiki/"). This will still include a lot of garbage, but
#    the following parts will just ignore it
# 6. Remove all duplicates
# 7. For each line, get the wiki page for the item
# 8. Get the line containing "API"
# 9. Get the part containing "ids="
# 10. Remove the "ids=" part

curl -s https://wiki.guildwars2.com/wiki/Crafting_material\#Basic_crafting_materials | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed 's/<a href=//' | sed 's/\"//g' | grep "^/wiki" | awk '!a[$0]++' | while read line; do curl -s https://wiki.guildwars2.com$line | grep API | grep -Eo 'ids=[0-9]+' | sed 's/ids=//' ; done
