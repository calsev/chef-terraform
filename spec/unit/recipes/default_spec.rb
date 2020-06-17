# frozen_string_literal: true

require 'spec_helper'
require 'shared_examples'

describe 'terraform::default' do
  let(:terraform_version) { '0.12.26' }
  context 'ubuntu' do
    let(:sha256sum) do
      '607bc802b1c6c2a5e62cc48640f38aaa64bef1501b46f0ae4829feb51594b257'
    end

    let(:checksums_file) { 'terraform_0.12.26_SHA256SUMS' }

    let(:checksums) do
      {
        'terraform_0.12.26_linux_amd64.zip' => sha256sum,
      }
    end

    let(:chef_run) do
      ChefSpec::ServerRunner.new do |node|
        allow(Chef::Recipe).to receive(:raw_checksums_to_hash)
          .and_return(checksums)
        allow(Chef::Recipe).to receive(:platform_family?).and_return('debian')
        allow(Chef::Resource).to receive(:signatures_trustworthy?)
          .and_return(true)
        # checksum for linux_amd64
        node.normal['terraform']['checksum'] = sha256sum
      end.converge(described_recipe)
    end

    it_behaves_like 'include_ark'
    it_behaves_like 'install_ark_terraform'

    context 'invalid gpg signatures' do
      it 'logs error' do
        allow(Chef::Resource).to receive(:signatures_trustworthy?)
          .and_return(false)
        rsrc = 'terraform_0.12.26_SHA256SUMS trust worthiness alert'
        expect(chef_run).to write_log(rsrc)
      end

      it 'ruby_block to raise does nothing' do
        rsrc = chef_run.ruby_block('raise if signature file cannot be trusted')
        expect(rsrc).to do_nothing
      end

      it 'triggers notifications due to bad signatures file' do
        log_name = "#{checksums_file} trust worthiness alert"
        resource = chef_run.log(log_name)
        notifications = [
          {
            notify: "remote_file[#{checksums_file}]",
            action: :delete,
          },
          {
            notify: 'ruby_block[raise if signature file cannot be trusted]',
            action: :run,
          },
        ]

        notifications.each do |notification|
          expect(resource).to notify(notification[:notify])
            .to(notification[:action]).immediately
        end
      end
    end
  end

  context 'windows' do
    let(:sha256sum) do
      'f232bf25dc32e618fbb692b98857d10a84e16e531e9ce5e87e060c1369bde092'
    end

    let(:checksums) do
      {
        'terraform_0.12.26_windows_amd64.zip' => sha256sum,
      }
    end

    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'windows',
                                 version: '2012R2') do |node|
        allow(Chef::Recipe).to receive(:raw_checksums_to_hash)
          .and_return(checksums)
        allow(Chef::Recipe).to receive(:platform_family?).and_return('windows')
        allow(Chef::Resource).to receive(:signatures_trustworthy?)
          .and_return(true)
        node.normal['terraform']['checksum'] = sha256sum
        node.normal['terraform']['win_install_dir'] = 'C:\terraform'
      end.converge(described_recipe)
    end

    it_behaves_like 'include_ark'
    it_behaves_like 'install_ark_terraform'

    it 'created windows install dir' do
      expect(chef_run).to add_windows_path('Windows install directory')
        .with(path: 'C:\terraform')
    end
  end
end
