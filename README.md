Salt states for Sentry
======================

In this repo you will find a set of [SaltStack](http://www.saltstack.com/community/) states that will get [Sentry](http://getsentry.com) running on a Centos 6 box.

Getting started with Vagrant
----------------------------

Clone this repo or a fork and then run:

      vagrant box add centos6 https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box
      # install the plugin only if you don't have it already
      vagrant plugin install vagrant-salt
      vagrant up

When it's done browse to [http://localhost:8080](http://localhost:8080)

Warning
-------

Event if it works it does not mean that a Sentry server configured this way is ready for production.
In particular the following issues should be addressed before putting in production:

1. Sentry is running as root
2. There is no caching layer, performance could be subpar depending on the expected traffic
3. By default [all hosts](https://github.com/unicolet/salt-sentry/blob/master/salt/states/pillar/sentry-server.sls#L6) are allowed, you should change that
4. Read carefully the [Sentry documentation](http://sentry.readthedocs.org/en/latest/)
5. Nginx hardening
6. SSL
7. Backups

Disclaimer
----------

Basically, it's always your fault.

License
-------

You are free to do what you want with this, but you should know that the world will end up being a better place if you share your improvements/bug fixes.

