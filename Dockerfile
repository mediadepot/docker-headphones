FROM debian:jessie
MAINTAINER jason@thesparktree.com

#Install base applications + deps
RUN echo "deb http://http.us.debian.org/debian stable main contrib non-free" | tee -a /etc/apt/sources.list
RUN apt-get -q update && \
    apt-get install -qy --force-yes python-cheetah python-openssl unrar curl && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

#Create headphones folder structure & set as volumes
RUN mkdir -p /srv/headphones/app && \
	mkdir -p /srv/headphones/config && \
	mkdir -p /srv/headphones/data


#Install Headphones
RUN git clone https://github.com/rembo10/headphones.git /srv/headphones/app


#Copy over start script and docker-gen files
ADD ./start.sh /srv/start.sh
RUN chmod u+x  /srv/start.sh
ADD ./template/headphones.tmpl /srv/headphones/config/headphones.tmpl

VOLUME ["/srv/headphones/app", "/srv/headphones/config", "/srv/headphones/data"]

EXPOSE 8081

CMD ["/srv/start.sh"]