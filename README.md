# rsa-archer-6-security-configuration-guide-baseline

InSpec profile to validate the secure configuration of RSA Archer 6.x, against the [RSA Archer 6.x Platform Security Configuration Guide](https://community.rsa.com/docs/DOC-32567). 

## Getting Started

It is intended and recommended that InSpec run this profile from a __"runner"__ host (such as a DevOps orchestration server, an administrative management system, or a developer's workstation/laptop) against the target remotely over __the RSA Archer API__.

__For the best security of the runner, always install on the runner the _latest version_ of InSpec and supporting Ruby language components.__ 

Latest versions and installation options are available at the [InSpec](http://inspec.io/) site.

## Tailoring to Your Environment
The following inputs must be configured in an inputs ".yml" file for the profile to run correctly for your specific environment. More information about InSpec inputs can be found in the [InSpec Profile Documentation](https://www.inspec.io/docs/reference/profiles/).

```yaml
url: ''

instancename: ''

user_domain: ''

username: ''

password: ''

ssl_verify: true

minimum_password_length: 9

minimum_alpha_characters: 2

minimum_numeric_characters: 1

minimum_special_characters: 1

minimum_uppercase_characters: 1

minimum_lowercase_characters: 1

password_change_interval: 90

previous_passwords_disallowed: 20

grace_logins: 0

unsuccessful_login_attempts: 3

session_timeout: 10

lockout_period: 999
```

# Running This Baseline Directly from Github

Before running this profile, the Archer API password must be set. This can be done by running the following command. 

    $ export ARCHER_API_PASSWORD=<password>

```
# How to run
inspec exec https://github.com/mitre/rsa-archer-6-security-configuration-guide-baseline/archive/master.tar.gz --input-file=<path_to_your_inputs_file/name_of_your_inputs_file.yml> --reporter=cli json:<path_to_your_output_file/name_of_your_output_file.json>
```

### Different Run Options

  [Full exec options](https://docs.chef.io/inspec/cli/#options-3)

## Running This Baseline from a local Archive copy 

If your runner is not always expected to have direct access to GitHub, use the following steps to create an archive bundle of this baseline and all of its dependent tests:

(Git is required to clone the InSpec profile using the instructions below. Git can be downloaded from the [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) site.)

When the __"runner"__ host uses this profile baseline for the first time, follow these steps: 

```
mkdir profiles
cd profiles
git clone https://github.com/mitre/rsa-archer-6-security-configuration-guide-baseline
inspec archive rsa-archer-6-security-configuration-guide-baseline
inspec exec <name of generated archive> --input-file=<path_to_your_inputs_file/name_of_your_inputs_file.yml> --reporter=cli json:<path_to_your_output_file/name_of_your_output_file.json>
```
For every successive run, follow these steps to always have the latest version of this baseline:

```
cd rsa-archer-6-security-configuration-guide-baseline
git pull
cd ..
inspec archive rsa-archer-6-security-configuration-guide-baseline --overwrite
inspec exec <name of generated archive> --input-file=<path_to_your_inputs_file/name_of_your_inputs_file.yml> --reporter=cli json:<path_to_your_output_file/name_of_your_output_file.json>
```

## Viewing the JSON Results

The JSON results output file can be loaded into __[heimdall-lite](https://heimdall-lite.mitre.org/)__ for a user-interactive, graphical view of the InSpec results. 

The JSON InSpec results file may also be loaded into a __[full heimdall server](https://github.com/mitre/heimdall)__, allowing for additional functionality such as to store and compare multiple profile runs. 

## Authors
* Rony Xavier - [rx294](https://github.com/rx294)

## Special Thanks
* Eugene Aronne - [ejaronne](https://github.com/ejaronne)
* Aaron Lippold - [aaronlippold](https://github.com/aaronlippold)
* Mohamed El-Sharkawi - [HackerShark](https://github.com/HackerShark)
* Shivani Karikar - [karikarshivani](https://github.com/karikarshivani)

## Contributing and Getting Help
To report a bug or feature request, please open an [issue](https://github.com/mitre/microsoft-sql-server-2014-instance-stig-baseline/issues/new).

## Additional References
- [RSA Archer 6.x API Guide](https://community.rsa.com/docs/DOC-41939).

### NOTICE

© 2018-2020 The MITRE Corporation.

Approved for Public Release; Distribution Unlimited. Case Number 18-3678.

### NOTICE

MITRE hereby grants express written permission to use, reproduce, distribute, modify, and otherwise leverage this software to the extent permitted by the licensed terms provided in the LICENSE.md file included with this project.

### NOTICE  

This software was produced for the U. S. Government under Contract Number HHSM-500-2012-00008I, and is subject to Federal Acquisition Regulation Clause 52.227-14, Rights in Data-General.  

No other use other than that granted to the U. S. Government, or to those acting on behalf of the U. S. Government under that Clause is authorized without the express written permission of The MITRE Corporation.

For further information, please contact The MITRE Corporation, Contracts Management Office, 7515 Colshire Drive, McLean, VA  22102-7539, (703) 983-6000.
