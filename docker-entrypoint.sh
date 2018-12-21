#!/bin/sh
set -e

if [ ! -f /etc/samba/smb.conf ]; then
    samba-tool domain provision --domain="${SAMBA_DC_DOMAIN}" \
        --adminpass="${SAMBA_DC_ADMIN_PASSWD}" \
        --server-role=dc \
        --realm="${SAMBA_DC_REALM}" \
        --dns-backend="${SAMBA_DC_DNS_BACKEND}" \
        --use-rfc2307 \
        --function-level=2008_R2 \
        --option="allow dns updates = disabled"
fi

if [ "$1" = 'samba' ]; then
    exec samba -i < /dev/null
fi

exec "$@"
