require 'spec_helper'

describe 'updatemotd' do
  context 'supported operating systems' do
    ['Debian'].each do |osfamily|
      describe "updatemotd class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should contain_class('updatemotd::params') }

        it { should contain_class('updatemotd::install') }
        it { should contain_class('updatemotd::config') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'updatemotd class without any parameters on RedHat/CentOS' do
      let(:facts) {{
        :osfamily        => 'RedHat',
        :operatingsystem => 'CentOS',
      }}

      it { should raise_error(Puppet::Error, /CentOS not supported/) }
    end
  end
end
