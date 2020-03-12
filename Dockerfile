FROM dcm4che/wildfly:18.0.1-8.0.1

ENV DCM4CHEE_ARC_VERSION 5.21.0
ENV DCM4CHE_VERSION ${DCM4CHEE_ARC_VERSION}

# download main modules
RUN cd $JBOSS_HOME \
    && curl -f http://maven.dcm4che.org/org/dcm4che/jai_imageio-jboss-modules/1.2-pre-dr-b04/jai_imageio-jboss-modules-1.2-pre-dr-b04.tar.gz | tar xz \
    && curl -f http://maven.dcm4che.org/org/dcm4che/jclouds-jboss-modules/2.2.0-noguava/jclouds-jboss-modules-2.2.0-noguava.tar.gz | tar xz \
    && curl -f http://maven.dcm4che.org/org/dcm4che/ecs-object-client-jboss-modules/3.0.0/ecs-object-client-jboss-modules-3.0.0.tar.gz | tar xz \
    && curl -f http://maven.dcm4che.org/org/dcm4che/dcm4che-jboss-modules/${DCM4CHE_VERSION}/dcm4che-jboss-modules-${DCM4CHE_VERSION}.tar.gz | tar xz

# download mysql module
ENV MYSQL_MODULES jdbc-jboss-modules-1.0.0-mysql
RUN cd $JBOSS_HOME \
    && curl -f http://maven.dcm4che.org/org/dcm4che/jdbc-jboss-modules/1.0.0/${MYSQL_MODULES}.zip -o ${MYSQL_MODULES}.zip \
    && unzip ${MYSQL_MODULES}.zip

# download mysql java connector
ENV MYSQL_CONNECTOR mysql-connector-java-5.1.36
RUN curl -L https://downloads.mysql.com/archives/get/p/3/file/${MYSQL_CONNECTOR}.tar.gz | tar xz \
    && mv ${MYSQL_CONNECTOR}/${MYSQL_CONNECTOR}-bin.jar $JBOSS_HOME/modules/com/mysql/main/

# download mysql-specific file
ENV DIST dcm4chee-arc-${DCM4CHEE_ARC_VERSION}-mysql
ENV DIST_FILE ${DIST}.zip
RUN cd \
    && curl --output ${DIST_FILE} --location \
        https://sourceforge.net/projects/dcm4che/files/dcm4chee-arc-light5/${DCM4CHEE_ARC_VERSION}/${DIST_FILE}/download \
    && unzip ${DIST_FILE} \
    && cp ${DIST}/deploy/dcm4chee-arc-ear-${DCM4CHEE_ARC_VERSION}-mysql.ear /docker-entrypoint.d/deployments/

COPY setenv.sh /
COPY configuration /docker-entrypoint.d/configuration

# Default configuration: can be overridden at the docker command line
ENV LDAP_URL=ldap://ldap:389 \
    LDAP_BASE_DN=dc=dcm4che,dc=org \
    KEYSTORE=/opt/wildfly/standalone/configuration/keystores/key.jks \
    TRUSTSTORE=/opt/wildfly/standalone/configuration/keystores/cacerts.jks
