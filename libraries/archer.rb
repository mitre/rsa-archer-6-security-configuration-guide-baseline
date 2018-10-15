# encoding: utf-8

require 'utils/filter'
require 'hashie/mash'
require 'resources/package'

# needed to skip cert verification when ssl_verify false
# this can be replaced with -SkipCertificateCheck in Powershell 6.x
SKIP_CERT_CHECK = %(

add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Ssl3, [Net.SecurityProtocolType]::Tls, [Net.SecurityProtocolType]::Tls11, [Net.SecurityProtocolType]::Tls12

)

LOGIN_PATH = '/api/core/security/login'.freeze
SECURITY_PARAMETERS_PATH = '/api/core/system/securityparameter'.freeze

class Archer < Inspec.resource(1)
  name 'archer'
  desc "Use the Elasticsearch InSpec audit resource to test the status of nodes in
    an Elasticsearch cluster."

  example "
    describe es_helper('http://eshost.mycompany.biz:9200/', username: 'elastic', password: 'changeme', ssl_verify: false) do
      its('node_count') { should >= 3 }
    end

    describe es_helper do
      its('node_name') { should include 'node1' }
      its('os') { should_not include 'MacOS' }
      its('version') { should cmp > 1.2.0 }
    end
  "

  attr_reader

  def initialize(opts = {})

    unless inspec.command('curl').exist?
      raise Inspec::Exceptions::ResourceSkipped, "Package `curl` and `powershell` not avaiable on the host"
    end

    @url = opts.fetch(:url, 'https://localhost/')

    @creds = {}
    @creds['InstanceName']      = opts.fetch(:instancename, nil)
    @creds['Username']      = opts.fetch(:username, nil)
    @creds['UserDomain'] = opts.fetch(:userdomain, nil)
    @creds['Password']   = opts.fetch(:password, nil)

    @ssl_verify = opts.fetch(:ssl_verify, true)
    login if session_token.nil?
  end

  def to_s
    "Archer Instance #{@creds['InstanceName']}"
  end

  def default_administrative_user
    content = securityparameter[0]
    verify_json_payload!(content)
    Hashie::Mash.new(content['RequestedObject'])
  end

  def general_user_parameter
    content = securityparameter[1]
    verify_json_payload!(content)
    Hashie::Mash.new(content['RequestedObject'])
  end

  def archer_services_parameter
    content = securityparameter[2]
    verify_json_payload!(content)
    Hashie::Mash.new(content['RequestedObject'])
  end

  def curl_command(request: nil, headers: nil, body: nil, path: nil)
    cmd_string = ['curl']
    cmd_string << '-k' unless @ssl_verify
    cmd_string << "-X #{request}" unless request.nil?
    cmd_string << headers.map { |x, y| "-H \"#{x}\":\"#{y}\"" }.join(' ') unless headers.nil?
    cmd_string << "-H 'Content-Type: application/json'"
    cmd_string << "-d '#{body.to_json}'" unless body.nil?
    cmd_string << URI.join(@url, path)
    cmd_string.join(' ')
  end

  def invoke_restmethod_command(request: nil, headers: nil, body: nil, path: nil)
    cmd_string = ['Invoke-RestMethod']
    cmd_string << "-Method #{request}" unless request.nil?
    cmd_string << "-Headers @{#{headers.map { |x, y| " '#{x}' = '#{y}'" }.join(';')} }" unless headers.nil?
    cmd_string << "-ContentType 'application/json'"
    cmd_string << "-Body '#{body.to_json}'" unless body.nil?
    cmd_string << URI.join(@url, path)
    cmd_string << '| ConvertTo-Json'
    return "#{SKIP_CERT_CHECK} \n #{cmd_string.join(' ')}" unless @ssl_verify

    cmd_string.join(' ')
  end

  def parse_response(response)
    JSON.parse(response)
  rescue JSON::ParserError => e
    raise Inspec::Exceptions::ResourceSkipped, "Error Parsing JSON response from Archer: #{ e.message}."
  end

  def session_token=(token)
    ENV['INSPEC_ARCHER_SESSION_TOKEN'] = token
  end

  def session_token
    ENV['INSPEC_ARCHER_SESSION_TOKEN']
  end

  def login
    if inspec.os.windows?
      cmd = invoke_restmethod_command(request: 'POST',
                                      headers: nil,
                                      body: @creds,
                                      path: LOGIN_PATH)
      response = inspec.powershell(cmd)
      verify_pwsh_success!(response)
    else
      cmd = curl_command(request: 'POST',
                         headers: nil,
                         body: @creds,
                         path: LOGIN_PATH)
      response = inspec.command(cmd)
      verify_curl_success!(response)
    end
    content = parse_response(response.stdout)
    verify_json_payload!(content)
    ENV['INSPEC_ARCHER_SESSION_TOKEN'] = content['RequestedObject']['SessionToken']
  end

  def securityparameter
    headers = { 'Authorization' => "Archer session-id=#{session_token}" }
    if inspec.os.windows?
      cmd = invoke_restmethod_command(request: 'GET',
                                      headers: headers,
                                      body: nil,
                                      path: SECURITY_PARAMETERS_PATH)
      response = inspec.powershell(cmd)
      verify_pwsh_success!(response)
      parse_response(response.stdout)['value']
    else
      cmd = curl_command(request: 'GET',
                         headers: headers,
                         body: nil,
                         path: SECURITY_PARAMETERS_PATH)
      response = inspec.command(cmd)
      verify_curl_success!(response)
      parse_response(response.stdout)
    end
  end

  def verify_curl_success!(cmd)
    raise Inspec::Exceptions::ResourceSkipped, "Error fetching Archer data from curl #{url}\nError: #{cmd.stderr.match(/curl: \(\d.\).*$/)}" unless cmd.exit_status.zero?
  end

  def verify_pwsh_success!(cmd)
    if cmd.stderr =~ /No HTTP resource was found that matches the request URI|DNS_FAIL/
      raise Inspec::Exceptions::ResourceSkipped, "Connection refused - please check the URL #{url} for accuracy"
    end

    if cmd.stderr =~ /Could not establish trust relationship for the SSL\/TLS secure channel/
      raise Inspec::Exceptions::ResourceSkipped, 'Connection refused - peer certificate issuer is not recognized; try setting ssl_verify to false'
    end

    raise Inspec::Exceptions::ResourceSkipped, "Error fetching Archer data from Invoke-RestMethod #{@url}: #{cmd.stderr}" unless cmd.exit_status.zero?
  end

  def verify_json_payload!(content)
    raise Inspec::Exceptions::ResourceSkipped, "Message: #{content['ValidationMessages'][0]['MessageKey']}" unless content['IsSuccessful']#{url}\nError: #{cmd.stderr.match(/curl: \(\d.\).*$/)}""
  end
end
