Sentry.init do |config|
  config.enabled_environments = %w[production]
  config.dsn = 'https://ef3d582c01e24c809cd0196878ca3b2b@o1377820.ingest.sentry.io/6688958'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end