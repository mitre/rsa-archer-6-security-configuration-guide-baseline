class ArcherConnection
  def initialize
    creds = nil
    if ENV['AWS_PROFILE']
      creds = Aws::SharedCredentials.new(profile_name: ENV['AWS_PROFILE'])
    else
      creds = Aws::Credentials.new(
        ENV['AWS_ACCESS_KEY_ID'],
        ENV['AWS_SECRET_ACCESS_KEY'],
        ENV['AWS_SESSION_TOKEN'],
      )
    end
    opts = {
      region: ENV['AWS_REGION'] || ENV['AWS_DEFAULT_REGION'],
      credentials: creds,
    }
    Aws.config.update(opts)
  end

  def sns_client
    @sns_client ||= Aws::SNS::Client.new
  end
end