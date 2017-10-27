# Xdebug
A Chassis extension to install and configure Xdebug on your Chassis server.

## Usage
1. Add this extension to your extensions directory `git clone git@github.com:Chassis/Xdebug.git extensions/xdebug`
2. Set your `config.local.yaml` PHP version to 5.6 or higher.
3. Run `vagrant provision`.
4. By default PHPSTORM is the default IDE. This can be overridden in your any of your [`.yaml`](https://github.com/Chassis/Chassis/blob/master/config.yaml#L6-#L9) files by adding in:
`ide: ATOM` and replacing ATOM with your IDE of choice. If you do this then please be sure to change your IDE Key in the Xdebug Helper extension mentioned below.

## PHPStorm Setup
### In Chrome
1. Install [Xdebug Helper](https://chrome.google.com/webstore/detail/xdebug-helper/eadndfjplgieldjbigjakmdgkmoaaaoc).
2. Go to `Settings -> More Tools -> Extensions` in Google Chrome.
3. Scroll down to `Xdebug helper` and click Options.
4. Change the IDE Key to `PhpStorm` and the value to `PHPSTORM` e.g.<br />![Xdebug Helper PHPStorm](https://bronsons-captured.s3.amazonaws.com/Xdebug_helper_2016-11-07_17-50-49.png)<br />
5. Enable Xdebug Helper. e.g.<br />![Enable Xdebug helper](https://bronsons-captured.s3.amazonaws.com/xdebug.png)<br />

### In PHPStorm
6. Go to `Preferences -> Languages + Frameworks -> PHP -> Servers` and add a mapping for your website.
 - `File/Directory` should be set to chassis folder (i.e. where the `Vagrantfile` is in).
 - `Absolute path on the server` should be set to `/vagrant`.
  e.g.<br />![Server mapping in PHPStorm](https://bronsons-captured.s3.amazonaws.com/phpstorm.png)<br />
7. Enable `Start Listening for PHP Debug Connections` e.g.<br />![Listen For PHP Debug Connections](https://bronsons-captured.s3.amazonaws.com/README.md_-_nodeissue_-_VolumesSitesnodeissue_2016-11-07_17-57-45.png)<br />
8. Set a breakpoint in PHPStorm and refresh the page you wish to debug in the browser and start debugging!

## Xdebug Profiling
If you'd like to enable Xdebug Profiling you can do so by doing either of the following:
1. Append `?XDEBUG_PROFILE=1` to a URL you'd like to profile.
2. Add `1` to the Xdebug Helper ![Chrome extension](https://bronsons-captured.s3.amazonaws.com/Xdebug_helper__2017-06-21_23-26-03.png).
3. The profiling logs will be save on your Chassis VM under `/tmp`. You'll need to `vagrant ssh` then `cd /tmp` to view them.

## Troubleshooting
If you're having issues with XDebug not working then there is a chance that port 9000 is being used by some other software on your computer. To work around this change the [port number](https://github.com/Chassis/Xdebug/blob/master/modules/xdebug/templates/xdebug.ini.erb#L6) to another value. e.g. `9001` and run `vagrant provision`
