$chassis_config = sz_load_config()
class { 'xdebug':
	path        => '/vagrant/extensions/xdebug',
	remote_host => $chassis_config[hosts]
}
