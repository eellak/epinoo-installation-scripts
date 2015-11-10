export FACTER_WORDPRESS=epinoodev.ellak.gr
export FACTER_MOODLE=moodledev.ellak.gr

# please change the password here or sypply it as arg
export FACTER_DB_ROOT_PASSWD=r00tp@ssw0rd
export FACTER_MOODLE_DB_PWD=example_password_please_change
export FACTER_DEFAULT_IP=83.212.119.95
export FACTER_WORDPRESS_IP=$(FACTER_DEFAULT_IP)
export FACTER_MOODLE_IP=$(FACTER_DEFAULT_IP)

#certificates for moodle
export FACTER_MOODLE_SSL_DIR=/etc/ssl/ellak
export FACTER_MOODLE_SSL_CERT=$(FACTER_MOODLE_SSL_DIR)/ssl.crt
export FACTER_MOODLE_SSL_KEY=$(FACTER_MOODLE_SSL_DIR)/ssl.key

export FACTER_MOODLE_FULLNAME=This is the full name of the moodle site
export FACTER_MOODLE_SHORTNAME=Shortname
# also, this should be changed to something else as well
export FACTER_MOODLE_ADMINPASS=admin_password_please_change

# shoulnd't be needed to change those:
#
export FACTER_MOODLE_URL=https://$(FACTER_MOODLE)
export FACTER_LISTEN_PORT=80
export FACTER_LISTEN_SSL_PORT=443
export FACTER_WWW_ROOT=/var/www
export FACTER_WORDPRESS_ROOT=$(FACTER_WWW_ROOT)/$(FACTER_WORDPRESS)
export FACTER_MOODLE_ROOT=$(FACTER_WWW_ROOT)/$(FACTER_MOODLE)
export FACTER_WWW_USER=www-data

#epinoo wordpress settings
export FACTER_WORDPRESS_DB_PWD=example_password_please_change
export FACTER_WORDPRESS_UNIQUE_PHRASE=please change this unique passphrase

# set the ffmpeg version
export FACTER_FFMPEG_VERSION=2.3.3

all:

.PHONY: init apache mysql bbb

test:
	@env | grep -i facter_

init:
	apt-get install -qq puppet
	service puppet stop
	update-rc.d puppet disable
	puppet apply basics.pp

puppet_modules:
	- puppet module install puppetlabs/mysql
	- puppet module install puppetlabs/apache
	- puppet module install puppetlabs/apt
	- puppet module install puppetlabs/vcsrepo
	- puppet module install Aethylred/shibboleth
	touch puppet_modules

php: puppet_modules
	puppet apply php.pp

apache: puppet_modules
	puppet apply apache.pp

mysql: puppet_modules
	puppet apply mysql.pp

ffmpeg:
	bash ffmpeg.sh

bbb: puppet_modules
	puppet apply 00-essentials.pp
	puppet apply 01-locale.pp
	puppet apply 02-sources.pp
	puppet apply 03-ffmpeg.pp
	puppet apply 04-bbb.pp

moodle: puppet_modules php apache mysql
	puppet apply moodle.pp

wordpress: puppet_modules php apache mysql
	install wp-config.php.erb /etc/puppet/templates/
	puppet apply wordpress.pp

ajenti: puppet_modules
	puppet apply ajenti.pp

all: init puppet_modules apache mysql bbb moodle wordpress ajenti
