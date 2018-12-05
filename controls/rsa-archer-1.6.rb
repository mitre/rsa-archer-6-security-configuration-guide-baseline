MINIMUM_LOWERCASE_CHARACTERS = attribute('minimum_lowercase_characters')

control 'rsa-archer-1.6' do
  title 'Lowercase characters require'
  desc 'When passwords are changed or new passwords are assigned, the new
  password must contain at least one lowercase character.'
  impact 'medium'
  desc 'check', 'In security parameters, check if LowercaseCharsRequired = 1.'
  desc 'fix', 'In security parameters, set LowercaseCharsRequired = 1.'
  tag 'nist': ['IA-5(1)', 'Rev_4']

  archer_api_helper = archer(url: attribute('url'),
                             instancename: attribute('instancename'),
                             user_domain: attribute('user_domain'),
                             username: attribute('username'),
                             password: attribute('password'),
                             ssl_verify: attribute('ssl_verify'))

  describe archer_api_helper do
    its('default_administrative_user.LowercaseCharsRequired') { should cmp >= MINIMUM_LOWERCASE_CHARACTERS }
    its('general_user_parameter.LowercaseCharsRequired') { should cmp >= MINIMUM_LOWERCASE_CHARACTERS }
    its('archer_services_parameter.LowercaseCharsRequired') { should cmp >= MINIMUM_LOWERCASE_CHARACTERS }
  end
end
