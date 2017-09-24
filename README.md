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

# TODO

Enhancements planned

+ ttnctl
   + [x] Provide registration link if not logged in
   + [x] Get default e-mail from user status
   + [x] Automatically download
   + [ ] Check for updates
+ [x] Include log in daily e-mail
+ Configuration
   + [ ] Additional parameters per gateway id
   + [ ] All command line parameters
+ [ ] Pushbullet support
+ [ ] Slack postings
+ [ ] Web page
