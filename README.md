[appurl]: http://www.thethingsnetwork.org/
[![The Things Network](https://ttnstaticfile.blob.core.windows.net/static/ttn/media/logo/TheThingsRond.png)][appurl]

# Monitoring of The Things Network Gateways

This script monitors TTN gateways, and sends e-mails when a problem is
detected, or gateway parameters change. It also sends a daily summary
of all TTN gateways for which you are listed as an owner.

# Table of Contents
1. [Initial Setup](#initial-setup)
1. [Gateway Summary](#gateway-summary)
1. [Configuration File](#configuration-file)
1. [Docker](#docker)
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
[this link](https://account.thethingsnetwork.org/users/authorize?client_id=ttnctl&redirect_uri=/oauth/callback/ttnctl&response_type=code) and
authenticate to TTN, if necessary. Copy the provided token and
login with:

```
bin/ttnctl user login TOKEN
```
## Start the monitor in test mode

```
bin/monitor --test -v
```

In test mode, e-mails will be sent to the from address, not to the
e-mail addresses of the gateway. Verbose (-v) mode will show you what
is happening.

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

# Gateway Summary

```
bin/monitor --summary
```

This will print a summary of all the gateways on your account in a
format similar to the TTN Console.

# Configuration File

A configuration file can be used to specify defaults for command line
options, group gateways togather and specify per-gateway information.

By default *ttn-monitor* tries to open *.ttn-monitor.yaml* in the current directory.
If that does not exist it tries to open *~/.ttn-monitor.yaml*. The
*--config* option on the command line can be used to explicity specify
a config file from the command line.

The config file is in [YAML](http://www.yaml.org/start.html) format.

Global parameters:
+ `from`: Specify the sending e-mail address
+ `test`: Specify test mode (`true` or `false`)
+ `late`: Time in seconds to consider a gateway non-responseive (default 90)
+ `timeout`: Time between gateway polls in seconds (default 300)
+ `cc`: Specify additional Cc addresses

Group defaults:
+ `cc`: Specify additional Cc addresses
+ `to`: Override gateway To address

Gateway parameters:
+ `alias`: A short name of a gateway
+ `cc`: Specify additional Cc addresses
+ `to`: Override gateway To address

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
	to: jch@honig.net
      
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

# Docker 

Work is in progress on building a Docker container to run
ttn-monitor.  

There are a couple of advantages of running ttn-monitor in a Docker
container.  The first is that all pre-requesites can be included, both
Linux packages and python packages and some configuration files.

Another advantage is that the monitor-status.db needs to be in sync
with changes in the code. Whenever the code chages, the Docker
container will be rebuilt without that file. 

# TODO

Enhancements planned

+ ttnctl
   + [ ] Check for updates
+ [ ] Pushbullet support
+ [ ] Slack postings
+ [ ] Web page
