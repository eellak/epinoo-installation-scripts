all:
	
.PHONY: init apache mysql bbb

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
	puppet apply 01-locale.pp
	puppet apply 02-sources.pp
	puppet apply 03-ffmpeg.pp
	#puppet apply 04-bbb.pp


