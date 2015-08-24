FROM linuxserver/baseimage-nginx
MAINTAINER Stian Larsen <lonix@linuxserver.io>

#Applying stuff
RUN apt-get update -q && \
apt-get install php5-fpm php5-mysql php5-mcrypt php5-curl php5-gd php5-cgi php5-pgsql php5-sqlite && \
apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*


#Adding Custom files
RUN mkdir /defaults 
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
ADD cron/ /etc/cron.d/
ADD defaults/ /defaults/
RUN chmod -v +x /etc/service/*/run && chmod -v +x /etc/my_init.d/*.sh


# Volumes and Ports
VOLUME /config
EXPOSE 80 443

## NOTES ##
## Delete files\folders not needed, e.g. if you dont run any cron commands, delete the cron folder and the "ADD cron/ /etc/cron.d/" line. 
## The User abc, should be running everything, give that permission in any case you need it. 
## Do not upgrade the baseimage before we get a chance to look at it from a wholeheartly perspective. 
## When creating init's Use 10's where posible, its to allow add stuff in between when needed. also, do not be afraid to split custom code into several little ones. 
## Make stuff as quiet as posible "e.g. apt-get update -qq" (Does not apply to the "app" itself. e.g. plex)