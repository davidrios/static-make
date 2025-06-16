#!/bin/bash
set -e

VERSION="${VERSION:-4.4.1}"
ARCHIVE="make-$VERSION.tar.gz"
ZIG_VERSION="0.14.1"
ARCH=$(uname -m)

gpg --keyserver keyserver.ubuntu.com --recv-keys B2508A90102F8AE3B12A0090DEACCAAEDB78137A

curl -LO "https://ziglang.org/download/$ZIG_VERSION/zig-$ARCH-linux-$ZIG_VERSION.tar.xz"
tar xf "zig-$ARCH-linux-$ZIG_VERSION.tar.xz"
export PATH="$PWD/zig-$ARCH-linux-$ZIG_VERSION:$PATH"

curl -LO "https://ftpmirror.gnu.org/make/$ARCHIVE"
curl -LO "https://ftp.gnu.org/gnu/make/$ARCHIVE.sig"

gpg --verify "$ARCHIVE.sig" "$ARCHIVE"

tar xf "$ARCHIVE"

cd "make-$VERSION"
./configure CC="$CC"
make
mv make ..
