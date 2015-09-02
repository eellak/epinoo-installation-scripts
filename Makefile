

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


