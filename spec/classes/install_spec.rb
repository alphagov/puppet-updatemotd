require 'spec_helper'

describe 'updatemotd::install' do
  let(:facts) {{
    :osfamily => 'Debian',
  }}

  it { should contain_package('foo') }
end
