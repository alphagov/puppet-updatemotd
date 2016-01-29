require 'spec_helper'

describe 'updatemotd::script' do
  let(:facts) {{
    :osfamily => 'Debian',
  }}

  let(:title) { 'giraffe' }
  let(:config_dir) { '/etc/update-motd.d' }
  let(:config_file) { "#{config_dir}/50-giraffe" }

  describe 'order' do
    context 'valid values' do
      [30, '40'].each do |order, title|
        describe title.inspect do
          let(:params) {{
            :order   => order,
            :content => 'lion',
          }}

          it { should contain_file("#{config_dir}/#{order}-giraffe") }
        end
      end
    end

    context 'invalid values' do
      [1, 'ten', '100'].each do |order, title|
        describe title.inspect do
          let(:params) {{
            :order   => order,
            :content => 'lion',
          }}

          it { should raise_error(Puppet::Error,
            /does not match/
          )}
        end
      end
    end
  end

  describe 'source' do
    let(:params) {{
      :source => 'puppet:///zoo/zebra',
    }}

    it { should contain_file(config_file).with(
      :mode    => '0755',
      :source  => 'puppet:///zoo/zebra',
      :content => nil,
      :require => 'Class[Updatemotd]'
    )}
  end

  describe 'content' do
    let(:params) {{
      :content => 'ZEBRA!',
    }}

    it { should contain_file(config_file).with(
      :mode    => '0755',
      :source  => nil,
      :content => 'ZEBRA!',
      :require => 'Class[Updatemotd]'
    )}
  end

  describe 'no source or content' do
    let(:params) {{ }}

    it { should raise_error(Puppet::Error,
      /source or content params are required/
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
