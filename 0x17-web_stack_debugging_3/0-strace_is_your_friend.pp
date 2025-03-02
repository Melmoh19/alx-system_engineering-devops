# Fix WordPress PHP file extension typo causing Apache 500 error

exec { 'fix-wordpress':
  command => 'sed -i s/phpp/php/g /var/www/html/wp-settings.php',
  path    => '/usr/local/bin:/usr/bin:/bin',
  onlyif  => 'grep -q "phpp" /var/www/html/wp-settings.php',
}

service { 'apache2':
  ensure  => running,
  require => Exec['fix-wordpress'],
}
