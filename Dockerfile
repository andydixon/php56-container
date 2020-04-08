FROM ubuntu
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update;\
	apt -y -qq install software-properties-common;\
	add-apt-repository ppa:ondrej/php;\
	apt update;\
	apt -y -qq install bsd-mailx postfix php5.6 php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-xml php5.6-json php5.6-curl vim php5.6-gd apache2;\
	rm -fr /var/lib/apt
RUN a2enmod rewrite
EXPOSE 80
ADD entrypoint.sh /
ADD default.vhost /etc/apache2/sites-enabled/000-default.conf
RUN echo "magic_quotes_gpc = Off;" >> /etc/php/5.6/apache2/conf.d/nddxn-hosting.conf && \
echo "register_globals = Off;" >> /etc/php/5.6/apache2/conf.d/nddxn-hosting.conf && \
echo "default_charset = UTF-8;" >> /etc/php/5.6/apache2/conf.d/nddxn-hosting.conf && \
echo "memory_limit = 64M;" >> /etc/php/5.6/apache2/conf.d/nddxn-hosting.conf && \
echo "max_execution_time = 36000;" >> /etc/php/5.6/apache2/conf.d/nddxn-hosting.conf && \
echo "upload_max_filesize = 999M;" >> /etc/php/5.6/apache2/conf.d/nddxn-hosting.conf && \
echo "safe_mode = Off;" >> /etc/php/5.6/apache2/conf.d/nddxn-hosting.conf && \
echo "mysql.connect_timeout = 20;" >> /etc/php/5.6/apache2/conf.d/nddxn-hosting.conf && \
echo "session.use_only_cookies = On;" >> /etc/php/5.6/apache2/conf.d/nddxn-hosting.conf && \
echo "session.use_trans_sid = Off;" >> /etc/php/5.6/apache2/conf.d/nddxn-hosting.conf && \
echo "session.cookie_httponly = On;" >> /etc/php/5.6/apache2/conf.d/nddxn-hosting.conf && \
echo "session.gc_maxlifetime = 172800;" >> /etc/php/5.6/apache2/conf.d/nddxn-hosting.conf && \
echo "allow_url_fopen = off;" >> /etc/php/5.6/apache2/conf.d/nddxn-hosting.conf
RUN sed -i 's/inet_protocols = all/inet_protocols = ipv4/' /etc/postfix/main.cf; mkfifo /var/spool/postfix/public/pickup
HEALTHCHECK --interval=5s --timeout=3s --retries=3 CMD curl -f http://localhost:80 || kill -9 1
CMD ["bash","/entrypoint.sh"]
