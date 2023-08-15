require 'spec_helper'

listen_port = 80

describe package('git') do
  it { should be_installed }
end


describe package('nginx') do
  it { should be_installed }
end

describe port(listen_port) do
  it { should be_listening }
end
