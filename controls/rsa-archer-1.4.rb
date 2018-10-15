control 'rsa-archer-1.4' do
  title 'Special characters required'
  desc 'When passwords are changed or new passwords are established, the new password must contain at least one special character.'
  tag 'check': 'In security parameters, check if UppercaseCharsRequired = 1'
  tag 'fix': 'In security parameters, set UppercaseCharsRequired = 1'
  tag 'nist': ['IA-5(1)', 'Rev_4']

  archer_api_helper = archer(url: attribute('url'),
                             instancename: attribute('instancename'),
                             user_domain: attribute('user_domain'),
                             username: attribute('username'),
                             password: attribute('password'),
                             ssl_verify: attribute('ssl_verify'))

  describe archer_api_helper do
    its('default_administrative_user.UppercaseCharsRequired') { should cmp >= 1 }
    its('general_user_parameter.UppercaseCharsRequired') { should cmp >= 1 }
    its('archer_services_parameter.UppercaseCharsRequired') { should cmp >= 1 }
  end
end