#!/bin/sh

set +e

if [ "$1" = "" ]; then
  echo "Provide a comment for your push:"
  echo "  $0 comment"
  exit
fi

git add . >/dev/null 2>&1
git commit -F- <<EOF
$@
EOF
git push -u origin master
