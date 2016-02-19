Cloudformation scripts to provide a server for tt-rss on AWS.

This is setup mainly for my personal use. To use, run the create
script with 3 command line options:

* MariaDB application username
* MariaDB application password
* MariaDB root password

If anyone besides me uses this you'll want to adjust the parameters in the
CloudFormation template. Also, there's hardcoded urls like "rss.lerch.org" that
should be adjusted, but in general it shouldn't be hard to modify for your tastes.

The template will setup a single server in us-west-2b availability zone (by default).
It will install apache, use [letsencrypt] to grab a ssl certificate for the domain
(currently hardcoded to rss.lerch.org) using the phenominal [acmetool] 0 dependency
go executable.

It will setup a mariadb docker container, grab a DB backup of an existing tt-rss instance,
and configure itself. You'll need an s3 bucket with ssl.config, reader_daemon and config.php
to run from.

Lastly it will setup an S3 backup job, start the update daemon and start apache. No SSH
should be needed into the instance if all goes according to plan...

[letsencrypt]: https://letsencrypt.org
[acmetool]: https://github.com/hlandau/acme 
