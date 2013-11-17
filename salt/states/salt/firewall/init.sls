firewall:
  service:
     - name: iptables
     - running
     - watch:
       - file: /etc/sysconfig/iptables

# enable http, postgres and ssh
/etc/sysconfig/iptables:
  file.sed:
    - before: tcp -p tcp --dport 22
    - after: multiport -p tcp --dports 22,80,5432
    - limit: ^-A INPUT -m state --state NEW -m
