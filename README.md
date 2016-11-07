# Xdebug
A Chassis extension to install and configure Xdebug on your Chassis server.

## Usage
1. Add this extension to your extensions directory `git clone git@github.com:Chassis/Xdebug.git extensions/xdebug`
2. Set your `local.config.yaml` PHP version to 5.6 or higher.
3. Run `vagrant provision`.

## PHPStorm Setup

1. Install [Xdebug Helper](https://chrome.google.com/webstore/detail/xdebug-helper/eadndfjplgieldjbigjakmdgkmoaaaoc).
2. Go to Settings -> More Tools -> Extensions in Google Chrome.
3. Scroll down to `Xdebug helper` and click Options.
4. Change the IDE Key to `PhpStorm` and the value to `PHPSTORM` e.g.<br />![Xdebug Helper PHPStorm](https://bronsons-captured.s3.amazonaws.com/Xdebug_helper_2016-11-07_17-50-49.png)<br />
5. Enable Xdebug Helper. e.g.<br />![Enable Xdebug helper](https://bronsons-captured.s3.amazonaws.com/xdebug.png)<br />
6. Enable `Start Listening for PHP Debug Connections` in PHPStorm. e.g.<br />![Listen For PHP Debug Connections](https://bronsons-captured.s3.amazonaws.com/README.md_-_nodeissue_-_VolumesSitesnodeissue_2016-11-07_17-57-45.png)<br />
7. Set a breakpoint in PhpStorm and refresh the page you wish to debug in the browser and start debugging!
