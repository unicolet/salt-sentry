postgres92-repo:
   file.managed:
     - name: /etc/yum.repos.d/pgdg-92-centos.repo
     - source: salt://postgres/pgdg.repo
     - user: root
     - group: root
     - mode: 644
     - template: jinja
     
#
# Salt 0.14 has bug for which pgrepo does not work correctly for
# yum repositories, working around it with file.managed
#
#  pkgrepo.managed:
#    - name: pgdg-92-centos 
#    - humanname: pgdg-92-centos 
#    - mirrorlist:
#    - baseurl: http://yum.postgresql.org/9.2/redhat/rhel-$releasever-$basearch
#    - gpgcheck: 1
#    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-92


postgresql92-server:
   pkg:
     - installed
     - require:
       - file: /etc/yum.repos.d/pgdg-92-centos.repo
   service:
     - name: postgresql-9.2
     - running
     - enable: True
     - require:
       - cmd: /etc/init.d/postgresql-9.2 initdb
     - watch:
       - file: /var/lib/pgsql/9.2/data/pg_hba.conf
       - file: /var/lib/pgsql/9.2/data/postgresql.conf

/etc/init.d/postgresql-9.2 initdb:
   cmd.wait:
    - watch:
      - pkg: postgresql92-server

/var/lib/pgsql/9.2/data/pg_hba.conf:
   file.managed:
     - source: salt://postgres/pg_hba.conf
     - user: postgres
     - group: postgres
     - mode: 600
     - template: jinja
     - require:
       - cmd: /etc/init.d/postgresql-9.2 initdb

/var/lib/pgsql/9.2/data/postgresql.conf:
   file.sed:
     - before: "#listen_addresses = 'localhost'"
     - after: "listen_addresses = '*'"
     - require:
       - cmd: /etc/init.d/postgresql-9.2 initdb
 
