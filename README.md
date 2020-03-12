# Supported tags and respective `Dockerfile` links

- [`5.21.0` (*5.21.0/Dockerfile*)](https://github.com/dcm4che-dockerfiles/dcm4chee-arc-psql/blob/5.21.0/Dockerfile)
- [`5.21.0-secure` (*5.21.0-secure/Dockerfile*)](https://github.com/dcm4che-dockerfiles/dcm4chee-arc-psql/blob/5.21.0-secure/Dockerfile)
- [`5.21.0-secure-ui` (*5.21.0-secure-ui/Dockerfile*)](https://github.com/dcm4che-dockerfiles/dcm4chee-arc-psql/blob/5.21.0-secure-ui/Dockerfile)

## How to use this image

See [Running on Docker](https://github.com/dcm4che/dcm4chee-arc-light/wiki/Running-on-Docker) at the
[dcm4che Archive 5 Wiki](https://github.com/dcm4che/dcm4chee-arc-light/wiki).

## Environment Variables

Below explained environment variables can be set as per one's application to override the default values if need be.
An example of how one can set an env variable in `docker run` command is shown below :

    -e ARCHIVE_DEVICE_NAME=my-dcm4chee-arc

_**Note**_ : If default values of any environment variables were overridden in startup of `slapd` or `postgres` containers, 
then ensure that the same values are also used for overriding the defaults during startup of archive container. 

#### `LDAP_URL`

URL for accessing LDAP (optional, default is `ldap://ldap:389`).

#### `LDAP_BASE_DN`

Base domain name for LDAP (optional, default is `dc=dcm4che,dc=org`).

#### `LDAP_ROOTPASS`

Password to use to authenticate to LDAP (optional, default is `secret`).

#### `LDAP_ROOTPASS_FILE`

Password to use to authenticate to LDAP via file input (alternative to `LDAP_ROOTPASS`).

#### `LDAP_DISABLE_HOSTNAME_VERIFICATION`

Indicates to disable the verification of the hostname of the certificate of the LDAP server,
if using TLS (`LDAP_URL=ldaps://<host>:<port>`) (optional, default is `true`).

#### `ARCHIVE_DEVICE_NAME`

Device name to lookup in LDAP for Audit Logging configuration (optional, default is `dcm4chee-arc`).

#### `POSTGRES_HOST`

Hostname/IP-Address of the PostgreSQL host. Required for using external PostgreSQL database to persist data.
If absent, embedded Java-based relational database H2 will be used to persist data (optional, default is `db`).

#### `POSTGRES_PORT`
             
Port of the PostgreSQL host (optional, default is `5432`)

#### `POSTGRES_DB`
                 
Name of the database to use (optional, default is `pacsdb`).

#### `POSTGRES_USER`
             
User to authenticate to PostgreSQL (optional, default is `pacs`).

#### `POSTGRES_USER_FILE`
                  
User to authenticate to PostgreSQL via file input (alternative to `POSTGRES_USER`).

#### `POSTGRES_PASSWORD`

User's password to use to authenticate to PostgreSQL (optional, default is `pacs`).

#### `POSTGRES_PASSWORD_FILE`
                      
User's password to use to authenticate to PostgreSQL via file input (alternative to `DB_PASSWORD`).

#### `POSTGRES_JDBC_PARAMS`
                      
Optional JDBC [Connection Parameters](https://jdbc.postgresql.org/documentation/head/connect.html) (e.g.: `connectTimeout=30`).

#### `JAVA_OPTS`

This environment variable is used to set the JAVA_OPTS during archive startup (optional, default is 
`"-Xms64m -Xmx512m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=256m -Djava.net.preferIPv4Stack=true -Djboss.modules.system.pkgs=org.jboss.byteman -Djava.awt.headless=true"`

#### `REVERSE_DNS`

Specifies if reverse DNS lookup is enabled for incoming DICOM and HL7 connections (optional, default is `true`).

#### `WILDFLY_CHOWN`

This environment variable is used to set the ownership to the storage directory (optional, default is 
`"/opt/wildfly/standalone /storage"`

#### `HTTP_PORT`

HTTP port of Keycloak (optional, default is `8080`).

#### `HTTPS_PORT`

HTTPS port of Wildfly (optional, default is `8443`).

#### `MANAGEMENT_HTTP_PORT`

HTTP port of Wildfly Administration Console (optional, default is `9990`).

#### `MANAGEMENT_HTTPS_PORT`

HTTPS port of Wildfly Administration Console (optional, default is `9993`).

#### `WILDFLY_ADMIN_USER` (Ignored by archive versions secured by Keycloak)

By default there is no admin user created so you won't be able to login to the Wildfly Administration Console.
User to authenticate to the Wildfly Administration Console.
(At archive versions secured by Keycloak, any user with assigned role `ADMINISTRATOR` is authorized to access the
Wildfly Administration Console.)

#### `WILDFLY_ADMIN_USER_FILE` (Ignored by archive versions secured by Keycloak)

User to authenticate to the Wildfly Administration Console via file input (alternative to WILDFLY_ADMIN_USER).

#### `WILDFLY_ADMIN_PASSWORD` (Ignored by archive versions secured by Keycloak)

User's password to use to authenticate to the Wildfly Administration Console.

#### `WILDFLY_ADMIN_PASSWORD_FILE` (Ignored by archive versions secured by Keycloak)

User's password to use to authenticate to the Wildfly Administration Console via file input (alternative to WILDFLY_ADMIN_PASSWORD).

#### `SUPER_USER_ROLE`

User role to identify super users, which have unrestricted access to all UI functions of the Archive, bypassing the
verification of user permissions (optional, default is `admin`).

#### `KEYSTORE`

Path to keystore file with private key and certificate for HTTPS (optional, default is
`/opt/keycloak/standalone/configuration/keystore/key.jks`, with sample key + certificate:
```
Subject    - CN=PACS_J4C,O=J4CARE,C=AT
Issuer     - CN=IHE Europe CA, O=IHE Europe, C=FR
Valid From - Sun Apr 02 06:38:46 UTC 2017
Valid To   - Fri Apr 02 06:38:46 UTC 2027
MD5 : 7a:b3:f7:5d:cf:6e:84:34:be:5a:7a:12:95:fa:46:76
SHA1 : a9:36:b3:b4:60:63:22:9e:f4:ae:41:d3:3b:97:ca:be:9b:a9:32:e9
```
provided by the docker image only for testing purpose).

#### `KEYSTORE_PASSWORD`

Password used to protect the integrity of the keystore specified by `KEYSTORE` (optional, default is `secret`).

#### `KEYSTORE_PASSWORD_FILE`

Password used to protect the integrity of the keystore specified by `KEYSTORE` via file input
(alternative to `KEYSTORE_PASSWORD`).

#### `KEY_PASSWORD`

Password used to protect the private key in the keystore specified by `KEYSTORE`
(optional, default is value of `KEYSTORE_PASSWORD`).

#### `KEY_PASSWORD_FILE`

Password used to protect the private key in the keystore specified by `KEYSTORE` via file input
(alternative to `KEY_PASSWORD`).

#### `KEYSTORE_TYPE`

Type (`JKS` or `PKCS12`) of the keystore specified by `KEYSTORE` (optional, default is `JKS`).

#### `TRUSTSTORE`

Path to keystore file with trusted certificates for HTTPS (optional, default is
`/opt/keycloak/standalone/configuration/keystore/cacerts.jks`, with sample CA certificate:
```
Subject    - CN=IHE Europe CA,O=IHE Europe,C=FR
Issuer     - CN=IHE Europe CA, O=IHE Europe, C=FR
Valid From - Fri Sep 28 11:19:29 UTC 2012
Valid To   - Wed Sep 28 11:19:29 UTC 2022
MD5 : 64:b6:1b:0f:8d:84:17:da:23:e4:e5:1c:56:ba:06:5d
SHA1 : 54:e0:10:c6:4a:fe:2c:aa:20:3f:50:95:45:82:cb:53:55:6b:07:7f
```
provided by the docker image only for testing purpose).

#### `TRUSTSTORE_PASSWORD`

Password used to protect the integrity of the keystore specified by `TRUSTSTORE` (optional, default is `secret`).

#### `TRUSTSTORE_PASSWORD_FILE`

Password used to protect the integrity of the keystore specified by `TRUSTSTORE` via file input
(alternative to `TRUSTSTORE_PASSWORD`).

##### `AUTH_SERVER_URL`

Base URL of the Keycloak server used for authenticating the client requests.
Default value is `http://keycloak:8080/auth`.

##### `REALM_NAME`

Name of the realm configured in Keycloak for securing the UI and RESTful services of the archive,
and the Wildfly Administration Console and Management API (optional, default is `dcm4che`). 

##### `SSL_REQUIRED`

Defining the SSL/HTTPS requirements for interacting with the Keycloak server:
- `none` - HTTPS is not required for any client IP address
- `external` - private IP addresses can access without HTTPS
- `all` - HTTPS is required for all IP addresses

(optional, default is `external`).

#### `ALLOW_ANY_HOSTNAME`

If the Keycloak server requires HTTPS and this config option is set to `true` the Keycloak server’s certificate is 
validated via the truststore, but host name validation is not done (optional, default value set is `true`).

##### `UI_CLIENT_ID`

Keycloak client ID for securing the UI of the archive (optional, default is `dcm4chee-arc-ui`).

#### `RS_CLIENT_ID`

Keycloak client ID for securing RESTful services of the archive (optional, default is `dcm4chee-arc-rs`).

#### `WILDFLY_CONSOLE`

Keycloak client ID for [securing the Wildfly Administration Console](https://docs.jboss.org/author/display/WFLY/Protecting+Wildfly+Adminstration+Console+With+Keycloak)
(optional, default is `wildfly-console`).

#### `WILDFLY_MANAGEMENT`

Keycloak client ID for [securing the Wildfly Management API](https://docs.jboss.org/author/display/WFLY/Protecting+Wildfly+Adminstration+Console+With+Keycloak).
(optional, default is `wildfly-management`).

#### `WILDFLY_EXECUTER_MAX_THREADS`

This environment variable sets the maximum threads allowed for the managed-executor-service in the Wildfly configuration
(optional, default is `100`).

#### `WILDFLY_PACSDS_MAX_POOL_SIZE`

This environment variable sets the maximum pool size allowed for the PacsDS datasource in the Wildfly configuration
(optional, default is `50`).

#### `WILDFLY_MDB_STRICT_MAX_POOL_SIZE`

Configured maximum number of message driven bean instances that the pool can hold at a given point in time.
(optional, default is `32`).

#### `WILDFLY_DISABLE_CACHING_FOR_SECURED_PAGES`

Indicates if Wildfly Undertow servlet container should set headers to disable caching for secured pages.
(optional, default is `true`).

#### `WILDFLY_JMS_QUEUE_STGCMTSCP_CONSUMER_COUNT`

The number of consumers consuming messages from queue `StgCmtSCP`. Limits number of concurrently processed Storage
Commitment requests (optional, default is `1`).

#### `WILDFLY_JMS_QUEUE_STGCMTSCU_CONSUMER_COUNT`

The number of consumers consuming messages from queue `StgCmtSCU`. Limits number of concurrently invoked Storage
Commitment requests (optional, default is `1`).

#### `WILDFLY_JMS_QUEUE_STGVERTASKS_CONSUMER_COUNT`

The number of consumers consuming messages from queue `StgVerTasks`. Limits number of concurrently invoked Storage
Verification tasks (optional, default is `1`).

#### `WILDFLY_JMS_QUEUE_MPPSSCU_CONSUMER_COUNT`

The number of consumers consuming messages from queue `MPPSSCU`. Limits number of concurrently forwarded MPPS messages.
(optional, default is `1`).

#### `WILDFLY_JMS_QUEUE_IANSCU_CONSUMER_COUNT`

The number of consumers consuming messages from queue `IANSCU`. Limits number of concurrently sent IAN notifications.
(optional, default is `1`).

#### `WILDFLY_JMS_QUEUE_HL7SEND_CONSUMER_COUNT`

The number of consumers consuming messages from queue `HL7Send`. Limits number of concurrently sent HL7v2 messages.
(optional, default is `1`).

#### `WILDFLY_JMS_QUEUE_RSCLIENT_CONSUMER_COUNT`

The number of consumers consuming messages from queue `RSClient`. Limits number of concurrently forwarded RESTful
requests (optional, default is `1`).

#### `WILDFLY_JMS_QUEUE_DIFFTASKS_CONSUMER_COUNT`

The number of consumers consuming messages from queue `DiffTasks`). Limits number of concurrently processed Studies
Compare Tasks (optional, default is `1`).

#### `WILDFLY_JMS_QUEUE_REJECTION_CONSUMER_COUNT`

The number of consumers consuming messages from queue `Rejection`). Limits number of concurrently processed Rejection Tasks.
Compare Tasks (optional, default is `1`).

#### `WILDFLY_JMS_QUEUE_EXPORT{N}_CONSUMER_COUNT`

The number of consumers consuming messages from queue `Export{N}` with N = [1..10]. Limits number of concurrently
processed Export Tasks from `Export{N}` queue (optional, default is `1`).

#### `WILDFLY_JMS_QUEUE_RETRIEVE{N}_CONSUMER_COUNT`

The number of consumers consuming messages from queue `Retrieve{N}` with N = [1..13]. Limits number of concurrently
processed Retrieve Tasks from `Retrieve{N}` queue (optional, default is `1`).

### [Logstash/GELF Logger](https://logging.paluch.biz/) configuration:

#### `LOGSTASH_HOST`

Hostname/IP-Address of the Logstash host. Required for emitting system logs to [Logstash](https://www.elastic.co/products/logstash).

#### `GELF_FACILITY`

Name of the Facility (optional, default is `wildfly`).

#### `GELF_LEVEL`

Log-Level threshold (optional, default is `WARN`).

#### `GELF_EXTRACT_STACK_TRACE`

Indicates if the Stack-Trace shall be sent in the StackTrace field (optional, default is `true`).

#### `GELF_FILTER_STACK_TRACE`

Indicates if Stack-Trace filtering shall be performed (optional, default is `true`).
