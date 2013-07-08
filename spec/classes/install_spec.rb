require 'spec_helper'

describe 'updatemotd::install' do
  let(:facts) {{
    :osfamily => 'Debian',
  }}

  # TODO: Test chain order.
  it { should contain_package('libpam-modules').with_ensure('present') }
  it { should contain_package('update-motd').with_ensure('purged') }
end
