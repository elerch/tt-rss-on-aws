Cloudformation scripts to provide a server for tt-rss on AWS.

This is setup mainly for my personal use. To use, run the create
script with 5 command line options:

* MariaDB application username
* MariaDB application password
* MariaDB root password
* Domain (full host) for letsencrypt certificate
* Email for letsencrypt certificate

If anyone besides me uses this you'll want to adjust the parameters in the
CloudFormation template. Also, there may be hardcoded urls like "rss.lerch.org" that
should be adjusted, but in general it shouldn't be hard to modify for your tastes.

The template will setup a single server in us-west-2b availability zone (by default).
It will install rkt with containers for mariadb, nginx, and the tt-rss update
daemon. It will use [letsencrypt] to grab a ssl certificate for the domain.

It will setup a mariadb docker container run via rkt, grab a DB backup of an existing tt-rss instance,
and configure itself. You'll need an s3 bucket with a tar file containining
the config directory.

Lastly it will setup an S3 backup job, start the update daemon container and 
start nginx. No SSH is designed be needed, but there are a couple bugs I have
run out of time to work on and may come back to:

1. The userdata script isn't being run properly on this arch AMI. I think
   the network may not be completely up by the time all the pacman magic is
   happening. I fixed this by logging in and grabbing the script from
   169.254.169.254/latest/user-data and simply running it.
2. Similarly the bootstrap script may not be getting kicked off after the
   scheduled reboot in #1 (though I'm not sure).

[letsencrypt]: https://letsencrypt.org
