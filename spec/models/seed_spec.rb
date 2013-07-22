require 'spec_helper'

describe Seed do

  before(:each) do
    @seed = FactoryGirl.build(:seed)
  end

  it 'should save a basic seed' do
    @seed.save.should be_true
  end

  context 'quantity' do
    it 'allows integer quantities' do
      @seed = FactoryGirl.build(:seed, :quantity => 99)
      @seed.should be_valid
    end

    it "doesn't allow decimal quantities" do
      @seed = FactoryGirl.build(:seed, :quantity => 99.9)
      @seed.should_not be_valid
    end

    it "doesn't allow non-numeric quantities" do
      @seed = FactoryGirl.build(:seed, :quantity => 'foo')
      @seed.should_not be_valid
    end

    it "allows blank quantities" do
      @seed = FactoryGirl.build(:seed, :quantity => nil)
      @seed.should_not be_valid
      @seed = FactoryGirl.build(:seed, :quantity => '')
      @seed.should_not be_valid
    end
  end

  context 'tradable' do
    it 'all three valid tradable_to values should work' do
      ['nowhere', 'locally', 'nationally', 'internationally', nil, ''].each do |t|
        @seed = FactoryGirl.build(:seed, :tradable_to => t)
        @seed.should be_valid
      end
    end

    it 'should refuse invalid tradable_to values' do
      @seed = FactoryGirl.build(:seed, :tradable_to => 'not valid')
      @seed.should_not be_valid
      @seed.errors[:tradable_to].should include("You may only trade seed nowhere, locally, nationally, or internationally")
    end

    it 'tradable? gives the right answers' do
      @seed = FactoryGirl.create(:seed, :tradable_to => 'nowhere')
      @seed.tradable?.should eq false
      @seed = FactoryGirl.create(:seed, :tradable_to => 'locally')
      @seed.tradable?.should eq true
      @seed = FactoryGirl.create(:seed, :tradable_to => 'nationally')
      @seed.tradable?.should eq true
      @seed = FactoryGirl.create(:seed, :tradable_to => 'internationally')
      @seed.tradable?.should eq true
    end

    it 'recognises a tradable seed' do
      FactoryGirl.create(:tradable_seed).tradable?.should == true
    end

    it 'recognises an untradable seed' do
      FactoryGirl.create(:untradable_seed).tradable?.should == false
    end
  end

end
