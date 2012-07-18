require 'spec_helper'
include ActionDispatch::TestProcess

describe User do
  before :each do
    @user = FactoryGirl.build :user
  end

  it 'is valid given proper values' do
    @user.should be_valid
  end

  describe '#name' do
    it 'is required' do
      @user.name = nil
      @user.should_not be_valid
    end

    it 'accepts only numbers, letters and _' do
      @user.name = 'user#1'
      @user.should_not be_valid
      @user.name = 'user 1'
      @user.should_not be_valid
    end

    it 'has a maximum lenght of 20' do
      @user.name = 21.times.map{'e'}.join
      @user.should_not be_valid
    end

    it 'has a minimum lenght of 3' do
      @user.name = 'ee'
      @user.should_not be_valid
    end
  end

  describe '#email' do
    it 'is required' do
      @user.email = nil
      @user.should_not be_valid
    end
  end

  describe '#date_of_birth' do
    it 'is required' do
      @user.date_of_birth = nil
      @user.should_not be_valid
    end

    it 'reffers to 13 years ago at least' do
      @user.date_of_birth = 12.years.ago.to_date
      @user.should_not be_valid
    end
  end

  describe '#gender' do
    it 'is required' do
      @user.gender = nil
      @user.should_not be_valid
    end

    it 'only accepts :male or :female as value' do
      @user.gender = :female
      @user.should be_valid
      @user.gender = :male
      @user.should be_valid
      @user.gender = :lord_varys
      @user.should_not be_valid
    end
  end

  describe 'privacy options' do
    fields = [:date_of_birth, :gender, :email, :location]

    fields.each do |field|
      describe "##{field}_privacy" do
        it 'is :public by default' do
          user = User.new
          user.send("#{field}_privacy").should == :public
        end

        it 'only accepts :public or :only_me' do
          @user["#{field}_privacy"] = :public
          @user.should be_valid
          @user["#{field}_privacy"] = :only_me
          @user.should be_valid
          @user["#{field}_privacy"] = :friends
          @user.should_not be_valid
        end

        it 'is required' do
          @user["#{field}_privacy"] = nil
          @user.should_not be_valid
        end
      end
    end
  end

  describe '#bio' do
    it 'has a maximum lenght of 500' do
      @user.bio = 501.times.map{'e'}.join
      @user.should_not be_valid
    end
  end

  describe "#status" do
    it 'is :active by default' do
      user = User.new
      user.status.should == :active
    end

    it 'only accepts :active or :blocked' do
      @user.status = :active
      @user.should be_valid
      @user.status = :blocked
      @user.should be_valid
      @user.status = :banned
      @user.should_not be_valid
    end

    it 'is required' do
      @user.status = nil
      @user.should_not be_valid
    end
  end

  it 'has an image uploader' do
    @user.image.class.should == ImageUploader
  end

  describe '#location' do
    it 'has a maximum lenght of 200' do
      @user.location = 201.times.map{'e'}.join
      @user.should_not be_valid
    end
  end

  describe 'notification options' do
    events = [:messages, :followers]

    events.each do |event|
      describe "#notify_#{event}" do
        it 'is active by default' do
          user = User.new
          user.send("notify_#{event}").should be_true
        end
      end
    end
  end

  describe '#find_for_oauth'
  describe '#new_with_session'
  describe '#role?'
  describe '#remove_role'
  describe '#add_role'
  describe '#active?'
  describe '#active_for_authentication?'
  it 'may sign in using email or name'
  

end
