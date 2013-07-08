require 'spec_helper'

describe 'updatemotd::config' do
  let(:facts) {{
    :osfamily => 'Debian',
  }}

  it { should contain_file('/etc/update-motd.d').with_ensure('directory') }
end
