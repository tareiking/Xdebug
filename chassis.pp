$xdebug_config = sz_load_config()
class { 'xdebug':
	path        => '/vagrant/extensions/xdebug',
	remote_host => $xdebug_config[hosts]
}
