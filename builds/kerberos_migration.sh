########################################################################
####### Setup for push linux users to ldap database with kerberos
########################################################################
#######
sudo yum install openldap-servers openldap-clients migrationtools
########################################################################


sudo cp /usr/share/openldap-servers/DB_CONFIG.example  /var/lib/ldap/DB_CONFIG
sudo chown -R ldap:ldap /var/lib/ldap/

########################################################################
sudo systemctl start slapd.service
sudo systemctl status slapd.service


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

########################################################################
########################################################################

sudo cp migrate_common.ph /usr/lib/migrationtools/migrate_common.ph 

########################################################################
########################################################################

grep demo /etc/passwd >/tmp/user
grep demo /etc/group >/tmp/groups

########################################################################
########################################################################

sudo ./migrate_passwd.pl /tmp/users /tmp/user.ldif
sudo ./migrate_group.pl /tmp/groups /tmp/groups.ldif

########################################################################
########################################################################

sudo ldapadd -x -D cn=ldapadm,dc=apache,dc=com -W -f /tmp/groups.ldif 
sudo ldapadd -x -D cn=ldapadm,dc=apache,dc=com -W -f /tmp/user.ldif 

########################################################################
########################################################################

sudo firewall-cmd --permanent --add-service=ldap
sudo firewall-cmd --reload

########################################################################
########################################################################

