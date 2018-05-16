FROM httpd
RUN apt update \
    && apt upgrade -y \
    && apt install -y openssl \
    && openssl req -new -x509 -nodes -out server.crt -keyout server.key -subj "/C=JP/ST=State/L=Locality/O=Organization/OU=Organizational Unit/CN=Common Name" \
    && mv server.crt /usr/local/apache2/conf/ \
    && mv server.key /usr/local/apache2/conf/ \
    && sed -i -e "s/#Include conf\/extra\/httpd-ssl.conf/Include conf\/extra\/httpd-ssl.conf/g" /usr/local/apache2/conf/httpd.conf \
    && sed -i -e "s/#LoadModule socache_shmcb_module modules\/mod_socache_shmcb.so/LoadModule socache_shmcb_module modules\/mod_socache_shmcb.so/g" /usr/local/apache2/conf/httpd.conf \
    && sed -i -e "s/#LoadModule ssl_module modules\/mod_ssl.so/LoadModule ssl_module modules\/mod_ssl.so/g" /usr/local/apache2/conf/httpd.conf
