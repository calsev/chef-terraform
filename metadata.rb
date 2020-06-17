name             'terraform'
maintainer       'Dang H. Nguyen'
maintainer_email 'haidangwa@gmail.com'
license          'Apache-2.0'
description      'Installs Terraform (terraform.io)'
version          '2.2.0'

depends 'ark', '~> 5.0'
depends 'gpg', '~> 1.1'

supports 'centos', '> 7.0'
supports 'debian', '> 7.0'
supports 'redhat', '> 7.0'
supports 'fedora'
supports 'ubuntu', '>= 16.04'

source_url 'https://github.com/haidangwa/chef-terraform'
issues_url 'https://github.com/haidangwa/chef-terraform/issues'
chef_version '>= 15.8'
