!/bin/bash
# Enhanced authentication method for Apache Knox and Ranger
#
########################################################################
# This script is used to setup kerberos server 
# This script is executed in the centos7 linux
# Usage: This script automatically sets up the kerberos server and configures the ldap database 
#
########################################################################
sudo yum install krb5-server

########################################################################
cp krb5.conf /etc/krb5.conf

########################################################################
cp kdc.conf  /var/kerberos/krb5kdc/kdc.conf 

########################################################################
cp kadm5.acl /var/kerberos/krb5kdc/kadm5.acl 
########################################################################
sudo kdb5_util create -s -r APACHE.COM
########################################################################
sudo systemctl enable kadmin
########################################################################
sudo systemctl enable krb5kdc
########################################################################
sudo systemctl start kadmin
########################################################################
sudo systemctl start krb5kdc
########################################################################
sudo systemctl status kadmin.service
########################################################################
sudo systemctl status krb5kdc.service
########################################################################
sudo firewall-cmd --permanent --add-service=kerberos
########################################################################
sudo firewall-cmd --reload
########################################################################

sudo kadmin.local
########################################################################
## kadmin.local: addprinc root/admin
## kadmin.local: addprinc -randkey host/cenvm02.apache.com
## kadmin.local: ktadd -k /tmp/cenvm02.keytab host/cenvm02.apache.com
## kadmin.local: listprincs
## kadmin.local: quit
########################################################################
####### Completes the setup for kerberos
########################################################################
#######
sudo yum install openldap-servers openldap-clients migrationtools
########################################################################
##
sudo cp /usr/share/openldap-servers/DB_CONFIG.example  /var/lib/ldap/DB_CONFIG
sudo chown -R ldap:ldap /var/lib/ldap/
########################################################################
sudo systemctl start slapd.service
sudo systemctl status slapd.service
##
##slappasswd
########################################################################
######Password :ldppassword
########################################################################
sudo cp db.ldif ~/db.ldif
sudo cp monitor.ldif ~/monitor.ldif
sudo cp base.ldif    ~/base.ldif
sudo ldapmodify -Y EXTERNAL  -H ldapi:/// -f ~/db.ldif
sudo ldapmodify -Y EXTERNAL  -H ldapi:/// -f monitor.ldif 
########################################################################
########################################################################
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif 
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif
########################################################################
########################################################################
sudo ldapadd -x -W -D "cn=ldapadm,dc=apache,dc=com" -f ~/base.ldif
sudo ldapadd -x -W -D "cn=ldapadm,dc=apache,dc=com" -f ~/user.ldif
########################################################################
########################################################################
sudo firewall-cmd --permanent --add-service=ldap
sudo firewall-cmd --reload


