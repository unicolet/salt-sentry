python-virtualenv:
  pkg.installed

extra-sentry-packages:
  pkg.installed:
    - names:
       - postgresql92-devel
       - expect
       - python-pip

sentryvenv:
    virtualenv.managed:
        - name: /opt/sentry/venv
        - no_site_packages: True
        - runas: vagrant
        - requirements: salt://sentry/requirements.txt
        - require:
            - pkg: python-virtualenv
            - service: postgresql-9.2
            - pkg: extra-sentry-packages
            - pkg: extra-sentry-packages
            - file: /opt/sentry/venv
            - file: /etc/profile.d/pg.sh
            - file: /etc/sentry.conf.py
            - postgres_database: {{ pillar['sentry_server']['db_name'] }}

/opt/sentry/venv:
  file.directory:
    - user: vagrant
    - group: vagrant
    - mode: 755
    - makedirs: True

/etc/profile.d/pg.sh:
  file.managed:
    - source: salt://sentry/pg.sh
    - user: root
    - group: root
    - mode: 644

/etc/sentry.conf.py:
  file.managed:
    - source: salt://sentry/sentry.conf.py
    - user: vagrant
    - group: root
    - mode: 640
    - template: jinja

# database user
{{ pillar['sentry_server']['db_user'] }}:
   postgres_user.present:
     - password: {{ pillar['sentry_server']['db_password'] }}
     - require:
       - service: postgresql-9.2

{{ pillar['sentry_server']['db_name'] }}:
   postgres_database.present:
     - owner: pg_sentry
     - require:
       - postgres_user: pg_sentry

sentry_db_upgrade:
   cmd.wait_script:
    - source: salt://sentry/sentry_upgrade.sh
    - user: vagrant 
    - watch:
      - virtualenv: sentryvenv
      - postgres_database: {{ pillar['sentry_server']['db_name'] }}

# emergency hook!
# for those cases when you want to force an upgrade, ie a venv split failure
/opt/sentry/venv/bin/sentry --config=/etc/sentry.conf.py upgrade && /bin/rm -f /opt/sentry/venv/must_upgrade:
   cmd.run:
    - user: vagrant
    - onlyif: /usr/bin/test -e /opt/sentry/venv/must_upgrade
    - require:
      - virtualenv: sentryvenv

/etc/init/sentry.conf:
   file.managed:
    - source: salt://sentry/sentry_init.conf
    - user: root
    - group: root
    - mode: 640 

stop sentry; start sentry:
   cmd:
     - wait
     - watch:
       - file: /etc/init/sentry.conf
       - virtualenv: sentryvenv

/etc/nginx/conf.d/sentry.conf:
   file.managed:
     - source: salt://sentry/nginx.conf
     - user: root
     - group: root
     - mode: 644
     - watch_in:
       - service: nginx
     - require:
       - pkg: nginx

/etc/nginx/conf.d/default.conf.no:
   file.rename:
     - source: /etc/nginx/conf.d/default.conf
     - force: true
     - watch_in:
       - service: nginx

raven=={{ pillar['raven']['version'] }}:
   pip.installed:
     - require:
       - pkg: extra-sentry-packages

