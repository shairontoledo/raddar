require 'spec_helper'

describe Page do
  before :each do
    @page = FactoryGirl.build :page
  end

  it 'is valid given proper values' do
    @page.should be_valid
  end

  it 'is invalid if it has no name' do
    @page.name = nil
    @page.should_not be_valid
  end

  it 'is invalid if it has no content' do
    @page.content = nil
    @page.should_not be_valid
  end

  it 'is valid if it has no title' do
    @page.title = nil
    @page.should be_valid
  end

  it 'has a unique name' do
    @page.save!
    other_page = FactoryGirl.build :page
    other_page.name = @page.name
    other_page.should_not be_valid
  end

  it 'has a maximum name lenght of 100' do
    @oage.name = 101.times.map{'e'}.join
    @page.should_not be_valid
  end

  it 'has a maximum title lenght of 200' do
    @oage.title = 201.times.map{'e'}.join
    @page.should_not be_valid
  end

  it 'has a maximum content lenght of 60_000' do
    @oage.content = 60_001.times.map{'e'}.join
    @page.should_not be_valid
  end
end
