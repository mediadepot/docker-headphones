#!/usr/bin/env bash
if [ ! -f /srv/headphones/config/config.ini ]; then
	#generate the config file for the first time using cheetah

	cheetah fill --oext ini --env /srv/headphones/config/headphones
fi

/usr/bin/python /srv/headphones/app/Headphones.py \
	--data_dir /srv/headphones/data \
	--config_file /srv/headphones/config/headphones.ini