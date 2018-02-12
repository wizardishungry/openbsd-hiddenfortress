#!/bin/sh
CDN_BASE=$1
OPENBSD_VER=$2
INSTALL_BASE=$CDN_BASE/amd64

echo "Downloading X11 packages"
echo $INSTALL_BASE
for f in xbase xfont xserv xshare ; do curl -sS -C - $INSTALL_BASE/$f$OPENBSD_VER.tgz -o data/$f$OPENBSD_VER.tgz ; done
exit
