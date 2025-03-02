# modules/apache_fix/manifests/init.pp
class apache_fix {
    package { 'libapache2-mod-php':
        ensure  => installed,
    }

    file { '/var/www/html/':
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
        ensure => running,
        enable => true,
    }
}
