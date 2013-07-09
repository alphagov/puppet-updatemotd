require 'spec_helper_system'

describe 'motd.tail' do
  context 'tail should update on login' do
    pp = <<-EOS
class { 'updatemotd':
  content => 'hullo thar!',
}
    EOS

    context puppet_apply(pp) do
      its(:stderr) { should be_empty }
      its(:exit_code) { should == 2 }
    end

    # We can't easily test the actual pam_motd using login(1).
    context shell('run-parts --lsbsysinit /etc/update-motd.d') do
      its(:stdout) { should =~ /hullo thar!\Z/ }
      its(:stderr) { should be_empty }
    end
  end
end
