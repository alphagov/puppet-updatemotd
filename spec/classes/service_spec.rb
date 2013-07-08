require 'spec_helper'

describe 'updatemotd::service' do
  let(:facts) {{
    :osfamily => 'Debian',
  }}

  it { should contain_service('foo') }
end
