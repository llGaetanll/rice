#!/bin/sh

# This command queries pacman for all locally installed packages explicitly
# installed by the user. For each of these packages, this creates a tab
# separated file where the first column is the name of the package, and the
# second is information about the package.

pacman -Qei \
| sed -n \
  -e '/^Name[[:blank:]]*:[[:blank:]]*/{s///p;}' \
  -e '/^Description[[:blank:]]*:[[:blank:]]*/{s///p;}' \
  -e '/^$/d' - \
| awk -F'\n' '{ORS= (NR%2==0) ? "\n" : "\t"; print $1}'
