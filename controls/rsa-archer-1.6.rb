control 'rsa-archer-1.6' do
  title 'Lowercase characters require'
  desc 'When passwords are changed or new passwords are assigned, the new password must contain at least one lowercase character.'
  tag 'check': 'In security parameters, check if SpecialCharsRequired = 1'
  tag 'fix': 'In security parameters, set SpecialCharsRequired = 1'
  tag 'nist': ['IA-5(1)', 'Rev_4']

  archer_api_helper = archer(url: attribute('url'),
                             instancename: attribute('instancename'),
                             user_domain: attribute('user_domain'),
                             username: attribute('username'),
                             password: attribute('password'),
                             ssl_verify: attribute('ssl_verify'))

  describe archer_api_helper do
    its('default_administrative_user.SpecialCharsRequired') { should cmp >= 1 }
    its('general_user_parameter.SpecialCharsRequired') { should cmp >= 1 }
    its('archer_services_parameter.SpecialCharsRequired') { should cmp >= 1 }
  end
end