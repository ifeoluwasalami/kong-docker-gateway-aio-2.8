#!/bin/bash

set -ex

/build/busybox wget https://meganode.wallarm.com/4.8/wallarm-4.8.6.x86_64-glibc.sh
sh ./wallarm-4.8.6.x86_64-glibc.sh --keep --noexec
cp -r wallarm /opt/
cp -r /opt/wallarm/modules/kong-28-openresty-11991-jammy/ /opt/wallarm/kong/ && rm -rf /opt/wallarm/modules/* && mv /opt/wallarm/kong /opt/wallarm/modules/
chown -R kong:kong /opt/wallarm

cp -v /build/docker-entrypoint.sh /docker-entrypoint.sh
cp -v /build/nginx.lua /usr/local/share/lua/5.1/kong/templates/nginx.lua
cp -v /build/nginx_kong.lua /usr/local/share/lua/5.1/kong/templates/nginx_kong.lua
chown -R kong:kong /usr/local/share/lua/5.1/kong/templates
sed -i -e '/HOST=0\.0\.0\.0/d' /opt/wallarm/env.list

rm -rf /build wallarm*