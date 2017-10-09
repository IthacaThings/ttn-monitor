[appurl]: http://www.thethingsnetwork.org/
[![The Things Network](https://ttnstaticfile.blob.core.windows.net/static/ttn/media/logo/TheThingsRond.png)][appurl]

# Monitoring of The Things Network Gateways

This script monitors TTN gateways, and sends e-mails when a problem is
detected, or gateway parameters change. It also sends a daily summary
of all TTN gateways for which you are listed as an owner.

# Table of Contents
1. [Initial Setup](#initial-setup)
1. [TODO](#todo)

# Initial Setup

## Install required packages

Install required packages.  On Debian/Ubuntu this would be

```
sudo apt-get install git python-dateutil unzip
```

## Clone the repo

```
git clone https://github.com/IthacaThings/ttn-monitor.git
```

## Enter the new directory

```
cd ttn-monitor
```

## Authenticate to your TTN account

Click
[this link]("https://account.thethingsnetwork.org/users/authorize?client_id=ttnctl&redirect_uri=/oauth/callback/ttnctl&response_type=code") and
authenticate to TTN, if necessary. Copy the provided token and
login with:

```
bin/ttnctl user login TOKEN
```

## Start the monitor in test mode

```
bin/monitor --test -v
```

In test mode, e-mails will be sent to your e-mail address, not to the
e-mail addresses of the gateway. Verbose (-v) mode will show you
output of what is happening.

## For each gateway you want to monitor

Have the owner add you as a collaborator with at least
`gateway:status` privs. To do this with the `ttnctl` command do the following:

```
bin/ttnctl gateway collaborators GWID USERNAME gateway:status gateway:location
```

note that `gateway:location` rights is optional.

From the GUI you can edit gateway settings and add collaborators
there. It does not seem to be possible to add just `gateway:status`
rights via the GUI; any collborators assigned via the GUI appear to
have `gateway:settings` rights.

# CONFIG FILE

A configuration file can be used to specify defaults for command line
options, group gateways togather and specify per-gateway information.

By default *ttn-monitor* tries to open *.ttn-monitor.yaml* in the current directory.
If that does not exist it tries to open *~/.ttn-monitor.yaml*. The
*--config* option on the command line can be used to explicity specify
a config file from the command line.

The config file is in [YAML](http://www.yaml.org/start.html) format.

Global parameters:
	+ from: string: Specify the sending e-mail address
	+ test: boolean: Specify test mode
	+ late: float: seconds XXX
	+ timeout: float: secons XXX
	+ cc: string or list: Specify additional cc's

Group defaults:
	+ cc: string or list: Specify additional cc's
	- to: string - Override the contact e-mail

Gateway parameters:
	+ alias: A string specifying a short name for the gateway
	+ cc: string or list: Specify additional cc's
	- to: string - Override the contact e-mail

Example:

```
---
Global:
  from: jch@honig.net
  cc: 
	- jch@honig.net
	- tmm@mcci.com
  test: true

ttn-ithaca:
  defaults:
    cc: gateway-mgmt@ttni.tech
  eui-008000000000bf84:
    alias: ttn-ith-bosak
  cce-tompkins:
    alias: ttn-ith-cce
  eui-008000000000bf4f:
    alias: ttn-ith-mcci
  eui-00800000a0000750:
    alias: ttn-ith-ecovillage
  eui-00800000a0000d4f:
    alias: ttn-ith-test
      
ttn-nyc:
  defaults:
    cc: demo@thethings.nyc
  eui-008000000000a4f1:
    alias: ttn-nyc-mcci
  eui-00800000a0000d50:
    alias: ttn-nyc-ccny
  eui-00800000a0000d51:
    alias: ttn-nyc-ffiller
  eui-00800000a0000ede:
    alias: ttn-nyc-midtown
  eui-00800000a00014ff:
    alias: ttn-nyc-chelsea
```


# TODO

Enhancements planned

+ ttnctl
   + [x] Provide registration link if not logged in
   + [x] Get default e-mail from user status
   + [x] Automatically download
   + [ ] Check for updates
+ [ ] Pushbullet support
+ [ ] Slack postings
+ [ ] Web page
