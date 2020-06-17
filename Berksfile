source 'https://supermarket.chef.io'

metadata

# this group can be excluded by berks; for example: `berks upload --except test`
group :test do
  cookbook 'terraform_test', path: 'test/fixtures/cookbooks/terraform_test'
  cookbook 'gpg', git: 'https://github.com/sous-chefs/gpg', ref: '2f682a1406047e99351d184fe18fff035a0c856c'
end
