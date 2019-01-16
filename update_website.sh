#!/bin/bash
OUTDIR=.
LOCAL_GHOST="http://localhost:2368"
GITHUB_PAGES_URL="http://twoandahalfvan.github.io"

echo "STORING $LOCAL_GHOST content in $OUTDIR folder"
wget -r -nH -P $OUTDIR -E -T 2 -np -k $LOCAL_GHOST/

echo "DELETING OBSOLETE STATIC CONTENT"
rm -rf `ls |grep -v README.md |grep -v source | grep -v *.sh`
git add .
git commit -m 'Delete generated website'

echo "REPLACING $LOCAL_GHOST URL WITH $GITHUB_PAGES_URL"
grep -r "$LOCAL_GHOST" -l --null . --exclude=*.sh --exclude-dir=source | xargs -0 sed -i "" -e "s#$LOCAL_GHOST#$GITHUB_PAGES_URL#g"

echo "REPLACING '/index.html' links with '/'"
grep -r "/index.html" -l --null . --exclude=*.sh --exclude-dir=source | xargs -0 sed -i "" -e "s#/index.html#/#g"

echo "REPLACING 'index.html' links with '../'"
grep -r "index.html" -l --null . --exclude=*.sh --exclude-dir=source | xargs -0 sed -i "" -e "s#index.html#\.\./#g"

echo "UPDATING GITHUB PAGES"
git add .
git commit -m 'Update website'
git push
