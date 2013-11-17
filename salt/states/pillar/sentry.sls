#
# configuration for Salt sentry logger and returner
raven:
  servers:
    - http://127.0.0.1
  public_key: d89ee01412da44b2971c966bbebecd1f
  secret_key: 24f2c7388ad24df8a4673c48d332e4aa
  project: salt
  tags:
    - os
    - cpuarch
  #
  # used by pip to install a specific raven version
  version: 3.5.2
