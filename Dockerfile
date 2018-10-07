FROM ubuntu:trusty

RUN DEP_MODULES="acl attr autoconf bison build-essential \
        debhelper dnsutils docbook-xml docbook-xsl flex gdb krb5-user \
        libacl1-dev libaio-dev libattr1-dev libblkid-dev \
        libcap-dev libcups2-dev libgnutls-dev libjson-perl \
        libldap2-dev libncurses5-dev libpam0g-dev libparse-yapp-perl \
        libpopt-dev libreadline-dev perl perl-modules pkg-config \
        python-all-dev python-dev python-dnspython python-crypto \
        xsltproc zlib1g-dev wget" && \
    apt-get update && \
    apt-get install -y $DEP_MODULES

RUN wget https://download.samba.org/pub/samba/stable/samba-4.6.6.tar.gz && \
    tar xzvf samba-4.6.6.tar.gz && \
    cd samba-4.6.6 && \
    ./configure --prefix=/usr/local/samba --enable-selftest --sysconfdir=/etc/samba --with-ldap --with-ads --with-winbind && \
    make -j4 && \
    make install

ENV PATH=/usr/local/samba/bin:/usr/local/samba/sbin:$PATH

VOLUME ["/var/lib/samba", "/etc/samba"]

ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["samba"]
