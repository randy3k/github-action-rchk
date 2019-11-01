#!/bin/bash

set -eo pipefail

cd /opt/R-svn/
. /opt/rchk/scripts/cmpconfig.inc
cd -

APT="$1"
if [ -n "$APT" ]; then
    sudo apt-get install $APT -y
fi

R --slave -e "install.packages('remotes', repos = 'https://cloud.r-project.org')"

R --slave -e "remotes::install_local(repos = 'https://cloud.r-project.org', upgrade = 'never')"

PACKAGE="$2"

echo "running rchk test for $PACKAGE"

cd /opt/R-svn/
. /opt/rchk/scripts/cmpconfig.inc
/opt/rchk/scripts/check_package.sh $PACKAGE
if [ $(cat packages/lib/$PACKAGE/libs/$PACKAGE.so.bcheck | wc -l) -gt 1 ]; then
  cat packages/lib/$PACKAGE/libs/$PACKAGE.so.bcheck
  FAIL=1
fi
if [ $(cat packages/lib/$PACKAGE/libs/$PACKAGE.so.maacheck | wc -l) -gt 1 ]; then
  cat packages/lib/$PACKAGE/libs/$PACKAGE.so.maacheck
  FAIL=1
fi
[ -z "$FAIL" ] || exit 1
