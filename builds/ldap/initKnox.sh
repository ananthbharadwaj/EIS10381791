
# Create knox related directories


 mkdir /knox
 mkdir /knox/bin
 mkdir /knox/conf
 mkdir /knox/lib


# Install Knox
 curl -O http://mirror.cogentco.com/pub/apache/knox/0.10.0/knox-0.10.0.zip 
 unzip /knox-0.10.0.zip -d /knox

cp  knox/topologies/sandbox.xml /knox/knox-0.10.0/conf/topologies/sandbox.xml
cp  knox/services/ /knox/knox-0.10.0/data/services/
cp  master /knox/knox-0.10.0/data/security/master

chmod -R +x /knox/knox-0.10.0/data/services/weather
chmod -R +x /knox/knox-0.10.0/bin/

# Start knox
java -jar knox/knox-0.10.0/bin/gateway.jar

