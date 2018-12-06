control 'rsa-archer-1.10' do
  title 'Maximum failed logon attempts'
  desc 'Accounts subject to 3 unsuccessful logon attempts must be locked.'
  impact 'medium'
  desc 'check', 'In security parameters, check if MaximumFailedLoginAttempts = 3.'
  desc 'fix', 'In security parameters, set MaximumFailedLoginAttempts = 3.'
  tag 'nist': ['AC-7', 'Rev_4']

  archer_api_helper = archer(url: attribute('url'),
                             instancename: attribute('instancename'),
                             user_domain: attribute('user_domain'),
                             username: attribute('username'),
                             password: attribute('password'),
                             ssl_verify: attribute('ssl_verify'))

  describe archer_api_helper do
    its('default_administrative_user.MaximumFailedLoginAttempts') { should cmp attribute('unsuccessful_login_attempts') }
    its('general_user_parameter.MaximumFailedLoginAttempts') { should cmp attribute('unsuccessful_login_attempts') }
    its('archer_services_parameter.MaximumFailedLoginAttempts') { should cmp attribute('unsuccessful_login_attempts') }
  end
end
