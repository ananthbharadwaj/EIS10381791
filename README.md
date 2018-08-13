# EIS10381791
SSSD + Kerberos + LDAP based authentication system for Hadoop clusters

Prerequisites
To get Kerberos running, NTP synchronisation and DNS resolution must be working.

Execution Steps:

To setup the Kerberos Server
EIS10381791/kerberos/kerberos-server.sh

To Migrate the existing user to LDAP and Kerberos
EIS10381791/kerberos/kerberos_migration.sh

To configure the SSSD with LDAP and Kerberos
EIS10381791/ldap/initLdap.sh

To initialize and setup Apache Knox
EIS10381791/ldap/initKnox.sh

Apache knox will be running in the port 8080(Access knox at http://localhost:8080)

Execution Demo:
![eisassignment](https://user-images.githubusercontent.com/38833701/43997596-d2a0f2da-9dd7-11e8-9b4c-2799a236674f.gif)


