FROM ubuntu
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update;apt -y -qq install software-properties-common;add-apt-repository ppa:ondrej/php; apt update; apt -y -qq install php5.6 php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-xml php5.6-json php5.6-gd apache2; rm -fr /var/lib/apt

EXPOSE 80
ADD entrypoint.sh /
CMD ["bash","/entrypoint.sh"]
