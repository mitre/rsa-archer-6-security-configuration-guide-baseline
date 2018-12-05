PASSWORD_CHANGE_INTERVAL = attribute('password_change_interval')

control 'rsa-archer-1.7' do
  title 'Password change interval'
  desc 'Existing passwords must be restricted to a 90-day maximum lifetime.'
  impact 'medium'
  desc 'check', 'In security parameters, check if PasswordChangeInterval = 90'
  desc 'fix', 'In security parameters, set PasswordChangeInterval = 90'
  tag 'nist': ['IA-5(1)', 'Rev_4']

  archer_api_helper = archer(url: attribute('url'),
                             instancename: attribute('instancename'),
                             user_domain: attribute('user_domain'),
                             username: attribute('username'),
                             password: attribute('password'),
                             ssl_verify: attribute('ssl_verify'))

  describe archer_api_helper do
    its('default_administrative_user.PasswordChangeInterval') { should cmp <= PASSWORD_CHANGE_INTERVAL }
    its('general_user_parameter.PasswordChangeInterval') { should cmp <= PASSWORD_CHANGE_INTERVAL }
    its('archer_services_parameter.PasswordChangeInterval') { should cmp <= PASSWORD_CHANGE_INTERVAL }
  end
end
