Salt states for Sentry
======================

In this repo you will find a set of [SaltStack](http://www.saltstack.com/community/) states that will get [Sentry](http://getsentry.com) running on a Centos 6 box.

Installing on Centos 6
----------------------

As root, clone this repo:

      cd /root
      git clone https://github.com/unicolet/salt-sentry.git
      cd salt-sentry
      git checkout -b local
      yum -y install salt-minion
      ln -s /root/salt-sentry/salt/states/salt /srv/salt
      ln -s /root/salt-sentry/salt/states/pillar /srv/pillar
      
Edit /etc/salt/minion and enable masterless mode by setting:

     file_client: local

Adjust [salt/states/pillar/sentry-server.sls](https://github.com/unicolet/salt-sentry/blob/master/salt/states/pillar/sentry-server.sls) to your environment

Run:

     salt-call state.highstate


Getting started with Vagrant (obsolete)
---------------------------------------

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

1. <del>Sentry is running as root</del> (Fixed in [15d2d49](https://github.com/unicolet/salt-sentry/commit/15d2d49d17076eeeacf079a61dbaaca6e0cad39a))
2. There is <del>no</del> a little caching layer, performance could be subpar depending on the expected traffic (Partly fixed in [9db87cc](https://github.com/unicolet/salt-sentry/commit/9db87cceee3ca473b8b683fc037bdae6ccbd6c2d) by enabling memcached by default)
3. By default [all hosts](https://github.com/unicolet/salt-sentry/blob/master/salt/states/pillar/sentry-server.sls#L8) are allowed, you should change that
4. Change the [secret key](https://github.com/unicolet/salt-sentry/blob/master/salt/states/pillar/sentry-server.sls#L12)!
4. Read carefully the [Sentry documentation](http://sentry.readthedocs.org/en/latest/)
5. Nginx hardening
6. SSL
7. Backups

Disclaimer
----------

As usual, this comes without any kind of warranty. Use the source and your own judgement.

License
-------

You are free to do what you want with this, but you should know that the world will end up being a better place if you share your improvements/bug fixes.

