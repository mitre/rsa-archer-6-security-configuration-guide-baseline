MINIMUM_SPECIAL_CHARACTERS = attribute('minimum_special_characters')

control 'rsa-archer-1.4' do
  title 'Special characters required'
  desc 'When passwords are changed or new passwords are established, the new
  password must contain at least one special character.'
  impact 'medium'
  desc 'check', 'In security parameters, check if SpecialCharsRequired = 1.'
  desc 'fix', 'In security parameters, set SpecialCharsRequired = 1.'
  tag 'nist': ['IA-5(1)', 'Rev_4']

  archer_api_helper = archer(url: attribute('url'),
                             instancename: attribute('instancename'),
                             user_domain: attribute('user_domain'),
                             username: attribute('username'),
                             password: attribute('password'),
                             ssl_verify: attribute('ssl_verify'))

  describe archer_api_helper do
    its('default_administrative_user.SpecialCharsRequired') { should cmp >= MINIMUM_SPECIAL_CHARACTERS }
    its('general_user_parameter.SpecialCharsRequired') { should cmp >= MINIMUM_SPECIAL_CHARACTERS }
    its('archer_services_parameter.SpecialCharsRequired') { should cmp >= MINIMUM_SPECIAL_CHARACTERS }
  end
end
