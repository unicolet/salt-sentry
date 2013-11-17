#!/bin/bash

/bin/cat > /tmp/xp << EOF
set timeout -1
set program [ lindex \$argv 0 ]
eval spawn \$program [ lrange \$argv 1 end ]
expect {
        "Would you like to create one now" {
                send "yes\r"
                expect "Username"
                send "admin\r"
                expect -re "Email|E-mail"
                send "test@gmail.com\r"
                expect "Password"
                send "admin\r"
                expect "Password"
                send "admin\r"
                exp_continue
         } "Migrated" {
                expect eof
         }
}
EOF

/usr/bin/expect /tmp/xp /opt/sentry/venv/bin/sentry --config=/etc/sentry.conf.py upgrade

/bin/rm -f /tmp/xp


