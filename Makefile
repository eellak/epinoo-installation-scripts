export FACTER_TEST=xaxaxa
export FACTER_EPINOO=epinoo.test.noc.ntua.gr
export FACTER_MOODLE=moodle.test.noc.ntua.gr
# please change the password here ir sypply it as arg
export FACTER_MOODLE_DB_PWD=example_password_please_change
export FACTER_DEFAULT_IP=83.212.119.95
export FACTER_EPINOO_IP=$(FACTER_DEFAULT_IP)
export FACTER_MOODLE_IP=$(FACTER_DEFAULT_IP)


# shoulnd't be needed to change those:
#
export FACTER_LISTEN_PORT=80
export FACTER_WWW_ROOT=/var/www
export FACTER_EPINOO_ROOT=$(FACTER_WWW_ROOT)/$(FACTER_EPINOO)
export FACTER_MOODLE_ROOT=$(FACTER_WWW_ROOT)/$(FACTER_MOODLE)
export FACTER_WWW_USER=www-data

all:
	
.PHONY: init apache mysql bbb

test:
	@env | grep -i facter_

init:
	apt-get install puppet
	service puppet stop
	update-rc.d puppet disable
	puppet apply basics.pp

apache:
	- puppet module install puppetlabs/apache
	puppet apply apache.pp

mysql:
	- puppet module install puppetlabs/mysql
	puppet apply mysql.pp

bbb:
	- puppet module install puppetlabs/apt
	puppet apply 00-essentials.pp
	puppet apply 01-locale.pp
	puppet apply 02-sources.pp
	puppet apply 03-ffmpeg.pp
	#puppet apply 04-bbb.pp

moodle:
	- puppet module install puppetlabs/vcsrepo
	puppet apply moodle.pp
