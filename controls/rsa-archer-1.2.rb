control 'rsa-archer-1.2' do
  title 'Alpha characters required'
  desc 'When passwords are changed or new passwords are established, the new
  password must contain at least two alpha characters.'
  impact 'medium'
  desc 'check', 'In security parameters, check if AlphaCharsRequired = 2.'
  desc 'fix', 'In security parameters, set AlphaCharsRequired = 2.'
  tag 'nist': ['IA-5(1)', 'Rev_4']

  archer_api_helper = archer(url: attribute('url'),
                             instancename: attribute('instancename'),
                             user_domain: attribute('user_domain'),
                             username: attribute('username'),
                             password: attribute('password'),
                             ssl_verify: attribute('ssl_verify'))

  describe archer_api_helper do
    its('default_administrative_user.AlphaCharsRequired') { should cmp >= attribute('minimum_alpha_characters') }
    its('general_user_parameter.AlphaCharsRequired') { should cmp >= attribute('minimum_alpha_characters') }
    its('archer_services_parameter.AlphaCharsRequired') { should cmp >= attribute('minimum_alpha_characters') }
  end
end
