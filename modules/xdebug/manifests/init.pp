class xdebug (
  $path = "/vagrant/extensions/xdebug"
) {
  package { 'php5-xdebug':
    ensure => latest,
    require => Package['php5-fpm']
  }

  file { '/etc/php5/fpm/conf.d/xdebug.ini':
    content => template('xdebug/xdebug.ini.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => 0644,
    require => Package['php5-fpm','php5-xdebug'],
    ensure  => 'present',
    notify  => Service['php5-fpm'],
  }
}
