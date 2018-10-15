control 'rsa-archer-1.8' do
  title 'Previous passwords disallowed'
  desc 'Passwords must be prohibited from reuse for a minimum of 20 generations.'
  tag 'check': 'In security parameters, check if PreviousPasswordsDisallowed = 20'
  tag 'fix': 'In security parameters, set PreviousPasswordsDisallowed = 20'
  tag 'nist': ['IA-5(1)', 'Rev_4']

  archer_api_helper = archer(url: attribute('url'),
                             instancename: attribute('instancename'),
                             user_domain: attribute('user_domain'),
                             username: attribute('username'),
                             password: attribute('password'),
                             ssl_verify: attribute('ssl_verify'))

  describe archer_api_helper do
    its('default_administrative_user.PreviousPasswordsDisallowed') { should cmp >= 20 }
    its('general_user_parameter.PreviousPasswordsDisallowed') { should cmp >= 20 }
    its('archer_services_parameter.PreviousPasswordsDisallowed') { should cmp >= 20 }
  end
end
