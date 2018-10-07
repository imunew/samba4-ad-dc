# samba4-ad-dc
This is a docker container running Samba4 as a domain controller.

## Volumes

- `/etc/samba`
- `/var/lib/samba`

## Environment Variables

| Name | Example | Description |
| --- | --- | --- |
| SAMBA_DC_REALM | workgroup.local | The realm to launch the DC into |
| SAMBA_DC_DOMAIN | workgroup | The NetBIOS Domain Name |
| SAMBA_DC_ADMIN_PASSWD | P@ssw0rd | The AD DC Administrator user password |
| SAMBA_DC_DNS_BACKEND | SAMBA_INTERNAL | The DNS backend to use |

## Run with docker command

```bash
docker run -d \
    -e SAMBA_DC_REALM='workgroup.local' \
    -e SAMBA_DC_DOMAIN='workgroup' \
    -e SAMBA_DC_ADMIN_PASSWD='P@ssw0rd' \
    -e SAMBA_DC_DNS_BACKEND='SAMBA_INTERNAL' \
     'imunew/samba4-ad-dc'
```

## Run with docker-compose

```yml
# docker-compose.yml
version: '3.2'
services:
  samba:
    image: imunew/samba4-ad-dc
    privileged: true
    environment:
      SAMBA_DC_REALM: workgroup.local
      SAMBA_DC_DOMAIN: workgroup
      SAMBA_DC_ADMIN_PASSWD: P@ssw0rd
      SAMBA_DC_DNS_BACKEND: SAMBA_INTERNAL
    ports:
      - 53:53
      - 53:53/udp
      - 88:88
      - 88:88/udp
      - 135:135
      - 139:139
      - 389:389
      - 389:389/udp
      - 445:445
      - 464:464
      - 464:464/udp
      - 636:636
      - 3268-3269:3268-3269
```

## reference 
I referred to the following.

- [LasLabs/docker-alpine-samba-dc: Samba4 Domain Controller Based on Alpine](https://github.com/LasLabs/docker-alpine-samba-dc)
