control 'rsa-archer-1.2' do
  title 'Alpha characters required'
  desc 'When passwords are changed or new passwords are established, the new
  password must contain at least two alpha characters.'
  impact 0.5
  tag 'check': 'In security parameters, check if AlphaCharsRequired = 2'
  tag 'fix': 'In security parameters, set AlphaCharsRequired = 2'
  tag 'nist': ['IA-5(1)', 'Rev_4']

  archer_api_helper = archer(url: attribute('url'),
                             instancename: attribute('instancename'),
                             user_domain: attribute('user_domain'),
                             username: attribute('username'),
                             password: attribute('password'),
                             ssl_verify: attribute('ssl_verify'))

  describe archer_api_helper do
    its('default_administrative_user.AlphaCharsRequired') { should cmp >= 2 }
    its('general_user_parameter.AlphaCharsRequired') { should cmp >= 2 }
    its('archer_services_parameter.AlphaCharsRequired') { should cmp >= 2 }
  end
end
