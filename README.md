[appurl]: http://www.thethingsnetwork.org/
[![The Things Network](https://ttnstaticfile.blob.core.windows.net/static/ttn/media/logo/TheThingsRond.png)][appurl]

# Monitoring of The Things Network Gateways

This script monitors the status of all gateways for which the
logged-in user has collaborator access. It sends e-mail whenever there
is an issue, or change in configuration. A summary e-mail is sent daily.

# Table of Contents
1. [Initial Setup](#initial-setup)
1. [TODO](#todo)

# Initial Setup

## Prerequeists

### Ubuntu

+ python-dateutil
+ unzip

# TODO

+ ttnctl
   + [ ] Provide registration link if not logged in
   + [ ] Get default e-mail from user status
   + [x] Automatically download
   + [ ] Check for updates
+ [ ] Include log in daily e-mail
+ Configuration
   + [ ] Additional parameters per gateway id
   + [ ] All command line parameters
+ [ ] Pushbullet support
+ [ ] Slack postings
+ [ ] Web page
