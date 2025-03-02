# fixes bad 'phpp' to 'php' in the wordpress file 'wp-settings.php' on apache
# fix 500 error
package { 'apache2':
  ensure => installed,
}

package { 'libapache2-mod-php':
  ensure => installed,
}

file { '/var/www/html/':
  ensure  => directory,
  owner   => 'www-data',
  group   => 'www-data',
  recurse => true,
}

exec { 'enable-mod-rewrite':
  command => '/usr/sbin/a2enmod rewrite',
  unless  => '/bin/grep -q "rewrite.load" /etc/apache2/mods-enabled/',
  notify  => Service['apache2'],
}

service { 'apache2':
  ensure  => running,
  enable  => true,
  require => [Package['apache2'], Exec['enable-mod-rewrite']],
}
