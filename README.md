# RSA-Archer-Security-Configuration-Guide-Baseline

InSpec Profile to validate the secure configuration of RSA Archer 6.x, against the **[RSA Archer 6.x Platform Security Configuration Guide](https://community.rsa.com/docs/DOC-32567)**. 

## Getting Started

It is intended and recommended that InSpec run this profile from a __"runner"__ host (such as a DevOps orchestration server, an administrative management system, or a developer's workstation/laptop) against the target remotely over __winrm__.

__For the best security of the runner, always install on the runner the _latest version_ of InSpec and supporting Ruby language components.__ 

Latest versions and installation options are available at the [InSpec](http://inspec.io/) site.

## Required Configurations

The following attributes must be configured in order for the profile to run correctly. These attributes can be configured in inspec.yml file or in an attributes file. More information about InSpec attributes can be found [here](https://www.inspec.io/docs/reference/profiles/).
    
| Attribute                     | Required | Default     | Description                                                           |
| :---                          | :---     | :---        | :---                                                               |
| url           | yes | `url: 'https://urltoarcherapp.org/'`        | Base URL of the RSA Archer application. |
| instancenamne | yes | `instancename: archerapp`                   | Name of the RSA Archer instance.        |
| user_domain   | no  | `user_domain: ''`                           | RSA Archer User Domain.                 |
| username      | yes | `username: restapiuser`                     | REST API User with at least `Read-Only` access to `Access Control` attributes on Archer.|
| password      | yes | `password: <%=ENV['ARCHER_API_PASSWORD']%>` | Password of the users is pulled from the ENV. Export the password to "ARCHER_API_PASSWORD". |
| ssl_verify    | no  | `ssl_verify: true`                          | Set this to 'false' if the Archer application uses self-signed certificates. |

## Running This Profile

Before running this profile, the Archer API password must be set. This can be done by running the following command. 

    $ export ARCHER_API_PASSWORD=s3cr3tpassw0rd

To run profile locally and directly from Github with cli & json output, run the following command.

    $ inspec exec /path/to/profile --reporter cli json:archer-results.json

## Viewing the JSON Results

The JSON results output file can be loaded into __[heimdall-lite](https://mitre.github.io/heimdall-lite/)__ for a user-interactive, graphical view of the InSpec results. 

The JSON InSpec results file may also be loaded into a __full heimdall server__, allowing for additional functionality such as to store and compare multiple profile runs.  

## Authors
- Rony Xavier [rx294](https://github.com/rx294)

## Special Thanks
- Eugene Aronne [ejaronne](https://github.com/ejaronne)
- Aaron Lippold [aaronlippold](https://github.com/aaronlippold)

## Additional References
- [RSA Archer 6.x API Guide](https://community.rsa.com/docs/DOC-41939).

## License

### NOTICE

© 2018 The MITRE Corporation.

Approved for Public Release; Distribution Unlimited. Case Number 18-3678.  

### NOTICE
MITRE hereby grants express written permission to use, reproduce, distribute, modify, and otherwise leverage this software to the extent permitted by the licensed terms provided in the LICENSE.md file included with this project.

### NOTICE  

This software was produced for the U. S. Government under Contract Number HHSM-500-2012-00008I, and is subject to Federal Acquisition Regulation Clause 52.227-14, Rights in Data-General.  

No other use other than that granted to the U. S. Government, or to those acting on behalf of the U. S. Government under that Clause is authorized without the express written permission of The MITRE Corporation.

For further information, please contact The MITRE Corporation, Contracts Management Office, 7515 Colshire Drive, McLean, VA  22102-7539, (703) 983-6000.
