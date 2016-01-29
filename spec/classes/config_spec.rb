require 'spec_helper'

# Focus on updatemotd::config proxy of updatemotd
describe 'updatemotd' do
  let(:facts) {{
    :osfamily => 'Debian',
  }}
  let(:file_tail) { '/etc/motd.tail' }

  describe 'symlinked motd' do
    it { should contain_file('/etc/motd').with(
      :ensure => 'link',
      :target => '/var/run/motd'
    )}
  end

  describe 'motd.tail' do
    describe 'source' do
      let(:params) {{
        :source => 'puppet:///zoo/zebra',
      }}

      it { should contain_file(file_tail).with(
        :ensure => 'present',
        :source  => 'puppet:///zoo/zebra',
        :content => nil
      )}
    end

    describe 'content' do
      let(:params) {{
        :content => 'ZEBRA!',
      }}

      it { should contain_file(file_tail).with(
        :ensure => 'present',
        :source  => nil,
        :content => 'ZEBRA!'
      )}
    end

    describe 'no source or content' do
      let(:params) {{ }}

      it { should contain_file(file_tail).with(
        :ensure => 'absent',
        :source  => nil,
        :content => nil
      )}
    end

    describe 'source and content' do
      let(:params) {{
        :content => 'oh no',
        :source  => 'puppet:///you/didnt',
      }}

      it { should raise_error(Puppet::Error,
        /source and content params are mutually exclusive/
      )}
    end
  end

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

      it { should raise_error(Puppet::Error, /is not a boolean/) }
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
        it { should contain_file(upstream_file).with_ensure(nil) }
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

      it { should raise_error(Puppet::Error, /is not a boolean/) }
    end
  end
end
