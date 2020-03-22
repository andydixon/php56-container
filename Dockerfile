FROM ubuntu
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update;apt -y -qq install software-properties-common;add-apt-repository ppa:ondrej/php; apt update; apt -y -qq install php5.6 php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-xml php5.6-json php5.6-gd apache2; rm -fr /var/lib/apt
RUN a2enmod rewrite
EXPOSE 80
ADD entrypoint.sh /
ADD default.vhost /etc/apache2/sites-enabled/000-default.conf
HEALTHCHECK --interval=5s --timeout=3s --retries=3 CMD curl -f http://localhost:80 || kill -9 1
CMD ["bash","/entrypoint.sh"]
