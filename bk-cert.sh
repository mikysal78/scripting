#!/bin/bash

DOMINIO='pippo.loc'


mkdir -p /root/bk-cert/mail
mv /etc/postfix/smtpd.* /root/bk-cert/mail/
ln -s /etc/letsencrypt/live/mail.$DOMINIO/privkey.pem /etc/postfix/smtpd.key
ln -s /etc/letsencrypt/live/mail.$DOMINIO/fullchain.pem /etc/postfix/smtpd.cert
service postfix reload
service dovecot reload


mkdir -p /root/bk-cert/ftp
mv /etc/ssl/private/pure-ftpd.pem /root/bk-cert/ftp/
cat /etc/letsencrypt/live/ftp.$DOMINIO/privkey.pem /etc/letsencrypt/live/ftp.$DOMINIO/fullchain.pem > /etc/ssl/private/
pure-ftpd.pem
service pure-ftpd-mysql restart

mkdir -p /root/bk-cert/ispconfig
mv /usr/local/ispconfig/interface/ssl/ispserver.* /root/bk-cert/ispconfig/
ln -s /etc/letsencrypt/live/srv.$DOMINIO/chain.pem /usr/local/ispconfig/interface/ssl/ispserver.bundle
ln -s /etc/letsencrypt/live/srv.$DOMINIO/cert.pem /usr/local/ispconfig/interface/ssl/ispserver.crt
ln -s /etc/letsencrypt/live/srv.$DOMINIO/chain.pem /usr/local/ispconfig/interface/ssl/ispserver.csr
ln -s /etc/letsencrypt/live/srv.$DOMINIO/privkey.pem /usr/local/ispconfig/interface/ssl/ispserver.key

service apache2 restart

