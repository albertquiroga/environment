#!/bin/bash

MATERIALSPAGELINK="https://wiki.guildwars2.com/wiki/Crafting_material"
echo "Extracting material item IDs from $MATERIALSPAGELINK. This will take some time... "

# Get the GW2 crafting materials page
MATERIALSPAGE="$(curl -s "$MATERIALSPAGELINK")"

# Find all http hyperlinks in it
HTTPHYPERLINKS="$(echo "$MATERIALSPAGE" | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]')"

# Remove the http hyperlink header and the surrounding double quotes from each hyperlink
QUOTEDHYPERLINKS="$(echo "$HTTPHYPERLINKS" | sed 's/<a href=//' | sed 's/\"//g')"

# Keep only the wiki page links and remove duplicates. This will still leave a lot of
# garbage in the list, but the next steps will just ignore it
WIKILINKSWITHNODUPLICATES="$(echo "$QUOTEDHYPERLINKS" | grep "^/wiki" | awk '!a[$0]++')"

# For each wiki page link
echo "$WIKILINKSWITHNODUPLICATES" | while read -r line; do

  # If the line is empty (probably EOF), exit the loop
  if [ -z "$line" ]
  then
    break
  fi

  # Follow that link and get the wiki item page
  ITEMPAGE="$(curl -s https://wiki.guildwars2.com$line)"

  # Retrieve the line containing "API"
  APILINE="$(echo "$ITEMPAGE" | grep API)"

  # Identify the part containing the ID and remove the "ids=" part
  ITEMID="$(echo "$APILINE" | grep -Eo 'ids=[0-9]+' | sed 's/ids=//')"

  # If it could retrieve an item ID
  if [ ! -z "$ITEMID" ]
  then
    # Print each item ID with its name and link, by removing the "/wiki/" part from the link
    PREFIX="/wiki/"
    ITEMNAME="${line#$PREFIX}"
    APIPREFIX="https://api.guildwars2.com/v2/commerce/prices/"
    #echo "${line#$PREFIX}\t\t$ITEMID"
    printf "%-40s %-10s %-70s\n" "$ITEMNAME" "$ITEMID" "$APIPREFIX$ITEMID"
  fi

done

echo "Done!"
