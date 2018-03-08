# A Chassis extension to install and configure Xdebug on your Chassis server
class xdebug (
  $path        = '/vagrant/extensions/xdebug',
  $remote_host  = $::xdebug_config[hosts],
  $php_version  = $::xdebug_config[php],
  $ide          = $::xdebug_config[ide]
) {
  $hosts = join($::xdebug_config[hosts],',')

  # Use the SSH client IP for the remote host
  $ssh_ip = generate('/bin/sh', '-c', 'echo $SSH_CLIENT | cut -d "=" -f 2 | awk \'{print $1}\'')

  # For backwards compatibility we'll keep PHPSTORM as the default
  if undef == $ide {
    $ide_name = 'PHPSTORM'
  } else {
    $ide_name = $ide
  }

  if ( ! empty( $::xdebug_config[disabled_extensions] ) and 'chassis/xdebug' in $::xdebug_config[disabled_extensions] ) {
    $package = absent
    $file    = absent
  } else {
    $package = latest
    $file    = 'present'
  }

  if versioncmp( "${php_version}", '5.6') < 0 {
    package { 'php5-xdebug':
        ensure  => $package,
        require => Package['php5-cli', 'php5-fpm']
    }

    file { '/etc/php5/fpm/conf.d/xdebug.ini':
      ensure  => $file,
      content => template('xdebug/xdebug.ini.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package['php5-fpm','php5-xdebug'],
      notify  => Service['php5-fpm'],
    }

    file { '/etc/php5/cli/conf.d/xdebug.ini':
      ensure  => $file,
      content => template('xdebug/xdebug.ini.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package['php5-cli','php5-xdebug'],
    }
  } else {
    package { 'php-xdebug':
      ensure  => $package,
      require => Package["php${php_version}-fpm", "php${php_version}-cli"],
      notify  => Service["php${php_version}-fpm"],
    }

    file { "/etc/php/${php_version}/fpm/conf.d/xdebug.ini":
      ensure  => $file,
      content => template('xdebug/xdebug.ini.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package["php${php_version}-fpm",'php-xdebug'],
      notify  => Service["php${php_version}-fpm"],
    }

    file { "/etc/php/${php_version}/cli/conf.d/xdebug.ini":
      ensure  => $file,
      content => template('xdebug/xdebug.ini.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package["php${php_version}-cli", 'php-xdebug'],
    }
  }

  # Export env vars for CLI support
  file_line { 'PHP_IDE_CONFIG':
    path => '/etc/environment',
    line => "PHP_IDE_CONFIG=\"serverName=${hosts}\""
  }
  file_line { 'XDEBUG_CONFIG':
    path => '/etc/environment',
    line => "XDEBUG_CONFIG=\"idekey=${ide_name}\""
  }
}
