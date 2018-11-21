control 'rsa-archer-1.12' do
  title 'Account lockout period'
  desc 'Accounts locked due to unsuccessful logon attempts will stay locked
  until unlocked by an administrator.'
  impact 0.5
  tag 'check': 'In security parameters, check if LockoutPeriod = 999'
  tag 'fix': 'In security parameters, set LockoutPeriod = 999'
  tag 'nist': ['AC-7', 'Rev_4']

  archer_api_helper = archer(url: attribute('url'),
                             instancename: attribute('instancename'),
                             user_domain: attribute('user_domain'),
                             username: attribute('username'),
                             password: attribute('password'),
                             ssl_verify: attribute('ssl_verify'))

  describe archer_api_helper do
    its('default_administrative_user.LockoutPeriod') { should cmp >= 999}
    its('general_user_parameter.LockoutPeriod') { should cmp >= 999 }
    its('archer_services_parameter.LockoutPeriod') { should cmp >= 999 }
  end
end
