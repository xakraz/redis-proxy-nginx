#!/usr/bin/env sh

set -e


nginx_config_dir="${NGINX_CONF_DIR:-/etc/nginx}"


if [ -z "$PROXY_PORT" ]; then
    export PROXY_PORT=6379
fi

if [ -z "$REDIS_HOST" ]; then
    echo "Environment variable REDIS_HOST is not set"
    exit 1
fi

if [ -z "$REDIS_PORT" ]; then
    export REDIS_PORT=6379
elif [[ "$REDIS_PORT" =~ "tcp://" ]]; then
   export REDIS_PORT=6379
fi

if [ -z "$DNS_RESOLVER" ]; then
    export DNS_RESOLVER=10.1.0.2
fi

sed -i'' "s/%{PROXY_PORT}/${PROXY_PORT}/" "${nginx_config_dir}/nginx.conf"
sed -i'' "s/%{REDIS_HOST}/${REDIS_HOST}/" "${nginx_config_dir}/nginx.conf"
sed -i'' "s/%{REDIS_PORT}/${REDIS_PORT}/" "${nginx_config_dir}/nginx.conf"
sed -i'' "s/%{DNS_RESOLVER}/${DNS_RESOLVER}/" "${nginx_config_dir}/nginx.conf"

nginx -T

exec "$@"