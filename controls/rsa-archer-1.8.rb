PREVIOUS_PASSWORDS_DISALLOWED = attribute('previous_passwords_disallowed')

control 'rsa-archer-1.8' do
  title 'Previous passwords disallowed'
  desc 'Passwords must be prohibited from reuse for a minimum of 20 generations.'
  impact 'medium'
  desc 'check', 'In security parameters, check if PreviousPasswordsDisallowed = 20'
  desc 'fix', 'In security parameters, set PreviousPasswordsDisallowed = 20'
  tag 'nist': ['IA-5(1)', 'Rev_4']

  archer_api_helper = archer(url: attribute('url'),
                             instancename: attribute('instancename'),
                             user_domain: attribute('user_domain'),
                             username: attribute('username'),
                             password: attribute('password'),
                             ssl_verify: attribute('ssl_verify'))

  describe archer_api_helper do
    its('default_administrative_user.PreviousPasswordsDisallowed') { should cmp >= PREVIOUS_PASSWORDS_DISALLOWED }
    its('general_user_parameter.PreviousPasswordsDisallowed') { should cmp >= PREVIOUS_PASSWORDS_DISALLOWED }
    its('archer_services_parameter.PreviousPasswordsDisallowed') { should cmp >= PREVIOUS_PASSWORDS_DISALLOWED }
  end
end
