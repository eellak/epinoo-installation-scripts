




init:
	apt-get install puppet
	service puppet stop
	puppet apply basics.pp

apache:
	- puppet module install puppetlabs/apache

