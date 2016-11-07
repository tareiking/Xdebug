class xdebug (
  $path        = "/vagrant/extensions/xdebug",
  $remote_host = $chassis_config[hosts],
  $php_version = $chassis_config[php]
) {
  $hosts = join($chassis_config[hosts],",")
  if versioncmp( "${php_version}", '5.6') < 1 {
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
  } else {
    package { 'php-xdebug':
      ensure => latest,
      require => Package["php${php_version}-fpm"],
      notify  => Service["php${php_version}-fpm"],
    }

    file { "/etc/php/${php_version}/fpm/conf.d/xdebug.ini":
      content => template('xdebug/xdebug.ini.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => 0644,
      require => Package["php${php_version}-fpm",'php-xdebug'],
      ensure  => 'present',
      notify  => Service["php${php_version}-fpm"],
    }

    package { 'php5-fpm':
        ensure => absent
      }
    }
}