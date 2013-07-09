require 'spec_helper'

# Focus on updatemotd::config proxy of updatemotd
describe 'updatemotd' do
  let(:facts) {{
    :osfamily => 'Debian',
  }}

  it { should contain_file('/etc/motd').with(
    :ensure => 'link',
    :target => '/var/run/motd'
  )}

  describe 'purge_directory' do
    context 'false, default' do
      let(:params) {{ }}

      it { should contain_file('/etc/update-motd.d').with(
        :ensure  => 'directory',
        :recurse => true,
        :force   => true,
        :purge   => false
      )}
    end

    context 'true' do
      let(:params) {{
        :purge_directory => true,
      }}

      it { should contain_file('/etc/update-motd.d').with(
        :ensure  => 'directory',
        :recurse => true,
        :force   => true,
        :purge   => true
      )}
    end

    context 'invalid type' do
      let(:params) {{
        :purge_directory => 'true',
      }}

      it { expect { should }.to raise_error(Puppet::Error, /is not a boolean/) }
    end
  end

  describe 'purge_directory' do
    upstream_files = %w{
      /etc/update-motd.d/00-header
      /etc/update-motd.d/10-help-text
      /etc/update-motd.d/91-release-upgrade
      /etc/update-motd.d/99-footer
    }

    context 'false, default' do
      let(:params) {{ }}

      upstream_files.each do |upstream_file|
        it { should_not contain_file(upstream_file) }
      end
    end

    context 'true' do
      let(:params) {{
        :preserve_upstream => false,
      }}

      upstream_files.each do |upstream_file|
        it { should_not contain_file(upstream_file).with_ensure(nil) }
      end
    end

    context 'invalid type' do
      let(:params) {{
        :purge_directory => 'true',
      }}

      it { expect { should }.to raise_error(Puppet::Error, /is not a boolean/) }
    end
  end
end
