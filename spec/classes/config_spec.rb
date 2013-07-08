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
end
