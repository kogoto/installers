#!/usr/bin/env bash

app=nginx
srcdir=/usr/local/src/$app
basedir=`dirname $0`
releasever=$1

[ ! -e $srcdir ] && mkdir $srcdir

pushd $srcdir

if [ ! -e nginx-${releasever} ]; then

  mkdir nginx-${releasever}

  if [ ! -e nginx-${releasever}.tar.gz ]; then
    wget http://nginx.org/download/nginx-${releasever}.tar.gz
  fi

  tar zxvf nginx-${releasever}.tar.gz -C nginx-${releasever} --strip-components 1
fi

[ ! -e /var/cache/nginx ] && mkdir -p /var/cache/nginx

cd nginx-${releasever}

./configure \
  --prefix=/etc/nginx \
  --sbin-path=/usr/sbin/nginx \
  --conf-path=/etc/nginx/nginx.conf \
  --error-log-path=/var/log/nginx/error.log \
  --http-log-path=/var/log/nginx/access.log \
  --pid-path=/var/run/nginx.pid \
  --lock-path=/var/run/nginx.lock \
  --http-client-body-temp-path=/var/cache/nginx/client_temp \
  --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
  --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
  --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
  --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
  --user=nginx \
  --group=nginx \
  --with-http_ssl_module \
  --with-http_realip_module \
  --with-http_addition_module \
  --with-http_sub_module \
  --with-http_dav_module \
  --with-http_flv_module \
  --with-http_mp4_module \
  --with-http_gunzip_module \
  --with-http_gzip_static_module \
  --with-http_random_index_module \
  --with-http_secure_link_module \
  --with-http_stub_status_module \
  --with-http_auth_request_module \
  --with-threads \
  --with-stream \
  --with-stream_ssl_module \
  --with-mail \
  --with-mail_ssl_module \
  --with-file-aio \
  --with-ipv6 \
  --with-http_spdy_module \
  --with-cc-opt='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -m64 -mtune=generic'

make && make install

rm -rf nginx-${releasever}.tar.gz

popd

adduser --system --no-create-home --user-group -s /sbin/nologin nginx

cp $basedir/nginx.service /usr/lib/systemd/system
systemctl enable nginx.service
systemctl daemon-reload
