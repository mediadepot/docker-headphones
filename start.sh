#!/usr/bin/env sh

#run the default config script
sh /srv/config.sh

#chown the headphones directory by the new user
chown mediadepot:mediadepot -R /srv/headphones

# download the latest version of HeadPhones
[[ ! -d /srv/headphones/app/.git ]] && su -c "git clone https://github.com/rembo10/headphones.git /srv/headphones/app" mediadepot

# opt out for autoupdates using env variable
if [ -z "$ADVANCED_DISABLEUPDATES" ]; then
	# update the application
	cd /srv/headphones/app/ && su -c "git pull" mediadepot
fi

if [ ! -f /srv/headphones/config/headphones.ini ]; then
	# create the base config file.
	echo "[General]" > /srv/headphones/config/headphones.ini
	echo "config_version = 5" >> /srv/headphones/config/headphones.ini
	echo "http_host = 0.0.0.0" >> /srv/headphones/config/headphones.ini
fi

# run HeadPhones
su -c "/usr/bin/python /srv/headphones/app/Headphones.py --datadir /srv/headphones/data --config /srv/headphones/config/headphones.ini" mediadepot
