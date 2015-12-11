FROM debian:jessie
MAINTAINER jason@thesparktree.com

#Create internal depot user (which will be mapped to external DEPOT_USER, with the uid and gid values)
RUN groupadd -g 15000 -r depot && useradd --uid 15000 -r -g depot depot

#Install base applications + deps
RUN echo "deb http://http.us.debian.org/debian stable main contrib non-free" | tee -a /etc/apt/sources.list
RUN apt-get -q update && \
    apt-get install -qy --force-yes git python-cheetah python-openssl unrar curl && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

#Create confd folder structure
RUN curl -L -o /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-linux-amd64
RUN chmod u+x  /usr/local/bin/confd
ADD ./conf.d /etc/confd/conf.d
ADD ./templates /etc/confd/templates

#Create headphones folder structure & set as volumes
RUN mkdir -p /srv/headphones/app && \
	mkdir -p /srv/headphones/config && \
	mkdir -p /srv/headphones/data/logs && \
	mkdir -p /srv/headphones/data/cache



#Install Headphones
RUN git clone https://github.com/rembo10/headphones.git /srv/headphones/app


#Copy over start script and docker-gen files
ADD ./start.sh /srv/start.sh
RUN chmod u+x  /srv/start.sh

VOLUME ["/srv/headphones/app", "/srv/headphones/config", "/srv/headphones/data"]

EXPOSE 8080

CMD ["/srv/start.sh"]