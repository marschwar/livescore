CarrierWave.configure do |config|
  if ENV['LOCAL_STORAGE']
    config.storage = :file
    Rails.logger.info 'Using local file system to store images'
  else
    config.storage = :aws
    # AWS section
    config.aws_bucket = ENV.fetch('S3_BUCKET_NAME')
    config.aws_acl    = :public_read # starting with 1.0 it must be 'public-read' instead
    # The maximum period for authenticated_urls is only 7 days.
    # config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7

    # Set custom options such as cache control to leverage browser caching
    config.aws_attributes = {
      cache_control: 'public,max-age=86400'
    }

    config.aws_credentials = {
      access_key_id:     ENV.fetch('AWS_ACCESS_KEY_ID'),
      secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
      region:            ENV.fetch('AWS_REGION') # Required
    }
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads"
end