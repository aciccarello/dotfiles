#!/bin/sh
FILES=$(git diff --name-only --diff-filter=ACMR | sed 's| |\\ |g')
[ -z "$FILES" ] && exit 0

# Prettify all selected files
echo "$FILES" | xargs ./node_modules/.bin/prettier --ignore-unknown --write

exit 0
