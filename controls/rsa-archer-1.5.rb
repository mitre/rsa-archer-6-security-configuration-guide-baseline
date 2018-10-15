control 'rsa-archer-1.5' do
  title 'Uppercase characters required'
  desc 'When passwords are changed or new passwords are established, the new
  password must contain at least one uppercase character.'
  tag 'check': 'In security parameters, check if LowercaseCharsRequired = 1'
  tag 'fix': 'In security parameters, set LowercaseCharsRequired = 1'
  tag 'nist': ['IA-5(1)', 'Rev_4']

  archer_api_helper = archer(url: attribute('url'),
                             instancename: attribute('instancename'),
                             user_domain: attribute('user_domain'),
                             username: attribute('username'),
                             password: attribute('password'),
                             ssl_verify: attribute('ssl_verify'))

  describe archer_api_helper do
    its('default_administrative_user.LowercaseCharsRequired') { should cmp >= 1 }
    its('general_user_parameter.LowercaseCharsRequired') { should cmp >= 1 }
    its('archer_services_parameter.LowercaseCharsRequired') { should cmp >= 1 }
  end
end
