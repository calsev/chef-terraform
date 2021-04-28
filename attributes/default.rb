default['terraform']['url_base'] = 'https://releases.hashicorp.com/terraform'
default['terraform']['version'] = '0.12.31'
default['terraform']['arch'] = if node['kernel']['machine'].match?(/x86_64/)
                                 'amd64'
                               else
                                 '386'
                               end

# Windows attributes
default['terraform']['win_install_dir'] = 'C:\terraform'
default['terraform']['owner'] = 'Administrator'
