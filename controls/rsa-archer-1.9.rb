control 'rsa-archer-1.9' do
  title 'Grace logons'
  desc 'After password expiration, zero grace logons are permitted using the expired password.'
  tag 'check': 'In security parameters, check if GraceLogins = 0'
  tag 'fix': 'In security parameters, set GraceLogins = 0'
  tag 'nist': ['IA-5(1)', 'Rev_4']

  archer_api_helper = archer(url: attribute('url'),
                             instancename: attribute('instancename'),
                             user_domain: attribute('user_domain'),
                             username: attribute('username'),
                             password: attribute('password'),
                             ssl_verify: attribute('ssl_verify'))

  describe archer_api_helper do
    its('default_administrative_user.GraceLogins') { should cmp 0 }
    its('general_user_parameter.GraceLogins') { should cmp 0 }
    its('archer_services_parameter.GraceLogins') { should cmp 0 }
  end
end