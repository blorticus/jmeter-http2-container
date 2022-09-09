FROM amazoncorretto:17
RUN yum -y update && yum install -y vim tar gzip
RUN curl -s https://dlcdn.apache.org/jmeter/binaries/apache-jmeter-5.5.tgz | tar xzC /opt
RUN ln -s /opt/apache-jmeter-5.5 /opt/jmeter && rm -rf /opt/jmeter/docs /opt/jmeter/printable_docs
RUN curl -s -o /opt/jmeter/lib/cmdrunner-2.2.jar https://repo1.maven.org/maven2/kg/apc/cmdrunner/2.2/cmdrunner-2.2.jar && \
    curl -s -o /opt/jmeter/lib/ext/jmeter-plugins-manager-1.7.jar https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-manager/1.7/jmeter-plugins-manager-1.7.jar
RUN java -cp /opt/jmeter/lib/ext/jmeter-plugins-manager-1.7.jar org.jmeterplugins.repository.PluginManagerCMDInstaller
ENV PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin:/opt/jmeter/bin
RUN /opt/jmeter/bin/PluginsManagerCMD.sh install bzm-http2
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
