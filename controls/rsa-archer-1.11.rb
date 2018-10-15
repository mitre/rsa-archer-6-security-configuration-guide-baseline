control 'rsa-archer-1.11' do
  title 'Session time-out'
  desc 'The operating system must initiate a session time-out after a 10 minute
  period of inactivity '
  tag 'check': 'In security parameters, check if SessionTimeout = 10'
  tag 'fix': 'In security parameters, set SessionTimeout = 10'
  tag 'nist': ['AC-11', 'Rev_4']

  archer_api_helper = archer(url: attribute('url'),
                             instancename: attribute('instancename'),
                             user_domain: attribute('user_domain'),
                             username: attribute('username'),
                             password: attribute('password'),
                             ssl_verify: attribute('ssl_verify'))

  describe archer_api_helper do
    its('default_administrative_user.SessionTimeout') { should cmp <= 10 }
    its('general_user_parameter.SessionTimeout') { should cmp <= 10 }
    its('archer_services_parameter.SessionTimeout') { should cmp <= 10 }
  end
end
