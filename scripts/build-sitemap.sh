#!/bin/bash

# the sitemap.txt file generated by this script belongs
# in the docs-support-network repository
# https://github.com/rackerlabs/docs-support-network

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
SITEMAP=$DIR/sitemap.txt
BASE_URL="https://support.rackspace.com"

echo "$BASE_URL/" > $SITEMAP
echo "$BASE_URL/how-to/" >> $SITEMAP

for file in $(find $DIR/content -name "*.md"); do
  slug=`basename -s .md $file`
  if [[ "$slug" != "index" ]]; then
    echo "$BASE_URL/how-to/$slug/" >> $SITEMAP
  fi
done
sort -o $SITEMAP $SITEMAP
# add front-matter yaml to make Jekyll happy
sed -i '' '1s/^/---\
permalink: sitemap.txt\
---\
/' $SITEMAP
