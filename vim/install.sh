#!/usr/bin/env bash

app=vim
srcdir=/usr/local/src/$app
basedir=`dirname $0`
releasever=$1

yum -y install lua lua-devel

[ ! -e $srcdir ] && mkdir $srcdir

pushd $srcdir

if [ ! -e vim-${releasever} ]; then
  if [ ! -e vim-${releasever}.tar.bz2 ]; then
    wget ftp://ftp.vim.org/pub/vim/unix/vim-${releasever}.tar.bz2

    if [ ! -e vim-${releasever}.tar.bz2 ]; then
      exit 1
    fi
  fi

  mkdir vim-${releasever}
  tar jxvf vim-${releasever}.tar.bz2 -C vim-${releasever} --strip-components 1
fi

cd vim-${releasever}
  
./configure \
  --with-features=huge \
  --enable-multibyte \
  --enable-luainterp=dynamic \
  --enable-gpm \
  --enable-cscope \
  --enable-fontset
  
make && make install

rm -rf $srcdir/vim-${releasever}.tar.bz2

popd
