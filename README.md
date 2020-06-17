terraform Cookbook
==================

Installs [Terraform][terraform] by HashiCorp.

[Terraform][terraform] is an open source tool that allows you to
configure entire infrastructure stack as code.

### Transfer of Ownership
As of v2.1.1, the ownership of this cookbook was transferred to [haidangwa]. From this point forward, all issues and pull requests should be submitted at https://github.com/haidangwa/chef-terraform.


Requirements
------------
### Chef Client
As of version 3.0.0, this cookbook will require minimum Chef Infra Client `>= 15.8`

### Cookbooks

This cookbook depends on the following cookbooks:
* [ark cookbook](https://supermarket.getchef.com/cookbooks/ark) to unpackage and install terraform.
* [gpg](https://supermarket.chef.io/cookbooks/gpg) to calculate and compare GPG hashes


### Platforms

The following platforms are supported and have been tested under
[Test Kitchen][testkitchen]:

* CentOS 7 * 8
* Debian 9 & 10
* Amazon Linux
* Ubuntu 16.04
* Ubuntu 18.04

Other versions of these OSs should work. Alternative Debian and RHEL
family distributions are also assumed to work. Please [report][issues]
any additional platforms you have tested so they can be added.

** Note for Debian:
[dayne](https://github.com/dayne) has found that this cookbook may not converge on Debian platforms. This can be fixed by doing running `apt update`, and then it will converge. This workaround has been applied to Test Kitchen by invoking the `terraform_test::ubuntu` recipe.

Usage
-----

Simply include `recipe[terraform]` in your run_list to have
[Terraform][terraform] installed. If you are using an artifact repository, like Nexus, hosted behind your corporate firewall, you must set the default attribute or override attributes in your roles or environments. The attributes are detailed velow.

Recipes
-------

### default

Installs [Terraform][terraform] from official pre-compiled binaries and gnupg with the gpgme recipe, below.


### gpgme

Installs gnupg2 and haveged to ensure the checksums file from HashiCorp can be trusted. This recipe is included when the default recipe is added to your node's run list.


Attributes
----------

### `node['terraform']['url_base']`

If you are using an artifact repository, like Nexus, hosted behind your corporate firewall, you must set the default attribute or override attributes in your roles or environments.

Default: https://releases.hashicorp.com/terraform


### `node['terraform']['version']`

The version of [Terraform][terraform] that will be installed (Default: 0.12.26)

### `node['terraform']['checksum']`

_As of v0.4.1, checksums are processed dynamically. There is no longer a need to specify the sha256 checksums of each terraform package in a cookbook attribute manually_

_As of v1.0.0, the checksum file will have its gpg signature verified. If the gpg signature is rejected, the chef run will fail.

_NOTE: All other attributes are considered internal and shouldn't
normally need to be changed._


#### Example setting default_attributes in a role (JSON file):

```json
{
  "name": "terraform_workstation",
  "description": "Role to apply onto a terraform workstation",
  "json_class": "Chef::Role",
  "default_attributes": {
    "terraform": {
      "url_base": "https://nexus.internal.com/nexus",
      "version": "0.12.5"
    }
  },
  "override_attributes": {},
  "run_list": [
    "recipe[terraform]"
  ]
}
```


Development
-----------

* Source hosted at [GitHub][repo]
* Report issues/questions/feature requests on [GitHub Issues][issues]


### Credit

This cookbook, especially the checksum stuff in
attributes file has been influenced by the [Packer
cookbook](https://supermarket.getchef.com/cookbooks/packer) by
[@sit](https://github.com/sit).

### License and Author

Author:: [Ross Timson][rosstimson]
<[ross@rosstimson.com](mailto:ross@rosstimson.com)>

Contributor:: [Dang Nguyen][haidangwa]
<[haidangwa@gmail.com](mailto:haidangwa@gmail.com)>

Copyright 2014, Ross Timson
2016, Dang H. Nguyen

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


[rosstimson]:         https://github.com/rosstimson
[haidangwa]:          https://github.com/haidangwa
[repo]:               https://github.com/haidangwa/chef-terraform
[issues]:             https://github.com/haidangwa/chef-terraform/issues
[terraform]:          http://www.terraform.io
[chefspec]:           https://github.com/sethvargo/chefspec
[foodcritic]:         https://github.com/acrmp/foodcritic
[rubocop]:            https://github.com/bbatsov/rubocop
[inspec]:             https://www.inspec.io/
[testkitchen]:        https://github.com/test-kitchen/test-kitchen
[ruby-gpgme]:         https://github.com/ueno/ruby-gpgme
