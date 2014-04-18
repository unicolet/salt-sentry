sentry_server:
  unix_user: sentry
  unix_group: sentry
  db_name: db_sentry
  db_user: pg_sentry
  db_password: sentryme
  sentry_url_prefix: http://10.1.23.99/
  allowed_hosts: "'*'"
  # unfortunately virtualenv will not interpolate pillar data in requirements
  # therefore version is statically set in requirements.txt
  sentry_version: 6.3.3
  secret_key: sdfgfdsgkfdg89_-7s89g789ugfgjkjkljj89e389902wkdk=
