




init:
	apt-get install puppet
	service puppet stop
	update-rc.d puppet disable
	puppet apply basics.pp

apache:
	- puppet module install puppetlabs/apache

