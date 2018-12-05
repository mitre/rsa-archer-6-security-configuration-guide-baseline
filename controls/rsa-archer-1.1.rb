control 'rsa-archer-1.1' do
  title 'Minimum Password Length'
  desc 'Passwords must be a minimum of 9 characters in length.'
  impact 'medium'
  desc 'check', 'In security parameters, check if MinPasswordLength = 9.'
  desc 'fix', 'In security parameters, set MinPasswordLength = 9.'
  tag 'nist': ['IA-5(1)', 'Rev_4']

  archer_api_helper = archer(url: attribute('url'),
                             instancename: attribute('instancename'),
                             user_domain: attribute('user_domain'),
                             username: attribute('username'),
                             password: attribute('password'),
                             ssl_verify: attribute('ssl_verify'))

  describe archer_api_helper do
    its('default_administrative_user.MinPasswordLength') { should cmp >= attribute('minimum_password_length') }
    its('general_user_parameter.MinPasswordLength') { should cmp >= attribute('minimum_password_length') }
    its('archer_services_parameter.MinPasswordLength') { should cmp >= attribute('minimum_password_length') }
  end
end
