require 'spec_helper'

describe 'updatemotd' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "updatemotd class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should include_class('updatemotd::params') }

        it { should contain_class('updatemotd::install') }
        it { should contain_class('updatemotd::config') }
        it { should contain_class('updatemotd::service') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'updatemotd class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
