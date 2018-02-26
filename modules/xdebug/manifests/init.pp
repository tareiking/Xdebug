# A Chassis extension to install and configure Xdebug on your Chassis server
class xdebug (
  $path        = '/vagrant/extensions/xdebug',
  $remote_host  = $::xdebug_config[hosts],
  $php_version  = $::xdebug_config[php],
  $ide          = $::xdebug_config[ide]
) {
  $hosts = join($::xdebug_config[hosts],',')

  # For backwards compatibility we'll keep PHPSTORM as the default
  if undef == $ide {
    $ide_name = 'PHPSTORM'
  } else {
    $ide_name = $ide
  }

  if versioncmp( "${php_version}", '5.6') < 0 {
    package { 'php5-xdebug':
        ensure  => latest,
        require => Package['php5-cli', 'php5-fpm']
    }

    file { '/etc/php5/fpm/conf.d/xdebug.ini':
      ensure  => 'present',
      content => template('xdebug/xdebug.ini.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package['php5-fpm','php5-xdebug'],
      notify  => Service['php5-fpm'],
    }

    file { '/etc/php5/cli/conf.d/xdebug.ini':
      ensure  => 'present',
      content => template('xdebug/xdebug.ini.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package['php5-cli','php5-xdebug'],
    }
  } else {
    package { 'php-xdebug':
      ensure  => latest,
      require => Package["php${php_version}-fpm", "php${php_version}-cli"],
      notify  => Service["php${php_version}-fpm"],
    }

    file { "/etc/php/${php_version}/fpm/conf.d/xdebug.ini":
      ensure  => 'present',
      content => template('xdebug/xdebug.ini.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package["php${php_version}-fpm",'php-xdebug'],
      notify  => Service["php${php_version}-fpm"],
    }

    file { "/etc/php/${php_version}/cli/conf.d/xdebug.ini":
      ensure  => 'present',
      content => template('xdebug/xdebug.ini.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package["php${php_version}-cli",'php-xdebug'],
    }
  }

  # Export necessary env vars
  file_line { 'PHP_IDE_CONFIG':
    path => '/etc/environment',
    line => "PHP_IDE_CONFIG=\"serverName=${hosts}\""
  }
  file_line { 'XDEBUG_CONFIG':
    path => '/etc/environment',
    line => "XDEBUG_CONFIG=\"idekey=${ide_name}\""
  }
}
