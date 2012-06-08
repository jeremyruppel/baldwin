require 'spec_helper'

describe Baldwin do
  before { Baldwin.env! }

  describe '#env!' do
    it 'should set BALDWIN_RAILS_NAME' do
      ENV[ 'BALDWIN_RAILS_NAME' ].should == "rails-#{Rails::VERSION::STRING}"
    end
    it 'should set BALDWIN_RAILS_PATH' do
      ENV[ 'BALDWIN_RAILS_PATH' ].should == "spec/rails/#{ENV[ 'BALDWIN_RAILS_NAME' ]}"
    end
  end

  describe '#root' do
    subject { Baldwin.root }
    it { should be_a( Pathname ) }
    its( :to_s ){ should eq( Dir.pwd ) }
  end

  describe '#rails' do
    subject { Baldwin.rails }
    it { should be_a( Pathname ) }
    its( :to_s ){ should eq( ENV[ 'BALDWIN_RAILS_PATH' ] ) }
  end

  describe '#apps' do
    subject { Baldwin.apps }
    it { should be_an( Array ) }
  end
end
