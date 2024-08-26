#!/bin/bash


EMAIL_USER ='lemail_user'
EMAIL_PASS ='lemail_#01PP'

umask 077
echo "relayhost = [smtp.sendgrid.net]:2525 " >> /etc/postfix/main.cf
echo "smtp_tls_security_level = encrypt"  >> /etc/postfix/main.cf
echo "smtp_sasl_auth_enable = yes"  >> /etc/postfix/main.cf
echo "smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd " >> /etc/postfix/main.cf
echo "header_size_limit = 4096000 " >> /etc/postfix/main.cf
echo "smtp_sasl_security_options = noanonymous"  >> /etc/postfix/main.cf

echo [smtp.sendgrid.net]:2525 "$EMAIL_USER":"$EMAIL_PASS" >> /etc/postfix/sasl_passwd

postmap /etc/postfix/sasl_passwd

rm -rf /etc/postfix/sasl_passwd

chmod 600 /etc/postfix/sasl_passwd.db

setsebool httpd_can_sendmail 1


to check

echo "Test Postfix Gmail https://example.com" | mail -s "Postfix Gmail" email-addr
