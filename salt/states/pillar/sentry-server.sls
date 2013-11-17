sentry_server:
  db_name: db_sentry
  db_user: pg_sentry
  db_password: s3ntrydb
  sentry_url_prefix: http://localhost:8080
  allowed_hosts: "'*'"
  # unfortunately virtualenv will not interpolate pillar data in requirements
  # therefore version is statically set in requirements.txt
  sentry_version: 6.3.3
  secret_key: V12THnLaRg8b1wk90Q7/6UrlWSzFjKbKyuLW5TJxR9XgTsJsl7NX4g==
