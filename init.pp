group { 'webmaster':
	ensure => present
}

group { 'clients':
	ensure => present
}

user { 'daniel':
	ensure     => present,
	managehome => true,
	uid        => 1000,
	groups     => [ 'webmaster', 'clients', 'daniel' ],
	shell      => "/bin/zsh"
}

package { 'vim':
	ensure => present,
	provider => 'yum'
}

package { 'curl':
	ensure => present
}

package { 'nginx':
	ensure => present
}

package { 'varnish':
	ensure => present
}

package { 'php-fpm':
	ensure => present
}

package { 'zsh':
	ensure => present
}

package { 'mysql':
	ensure => present
}

file { '/env':
	ensure => 'directory',
	owner  => root,
	group  => webmaster,
	mode   => 750
}




