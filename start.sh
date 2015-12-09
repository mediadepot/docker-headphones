#!/usr/bin/env bash
if [ ! -f /srv/headphones/config/headphones.ini ]; then
	#generate the config file for the first time using cheetah
	confd -onetime -backend rancher -prefix /2015-07-25
	chown -R depot:depot /srv/headphones

fi

su -c "/usr/bin/python /srv/headphones/app/Headphones.py --data_dir /srv/headphones/data --config_file /srv/headphones/config/headphones.ini" depot