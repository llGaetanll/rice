#!/bin/sh

# This file parses the icons in the `icons` file into an environment variable
# that lf can use.

# This file is sourced from xinitrc.

export LF_ICONS=`sed -e "s/\s*#.*//g" -e "/^$/d" -e "s/[[:space:]]\+/=/g" icons | paste -s -d: --`
