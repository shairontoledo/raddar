require 'spec_helper'

describe User do
  let :user do
    user = FactoryGirl.build :user
  end

  it 'is a Raddar model' do
    user.should be_a_kind_of(Raddar::Model)
  end

  it 'is valid given proper values' do
    user.should be_valid
  end

  describe '#name' do
    it 'is required' do
      user.name = nil
      user.should_not be_valid
    end

    it 'accepts only numbers, letters and _' do
      user.name = 'user#1'
      user.should_not be_valid
      user.name = 'user 1'
      user.should_not be_valid
    end

    it 'has a maximum lenght of 20' do
      user.name = 21.times.map{'e'}.join
      user.should_not be_valid
    end

    it 'has a minimum lenght of 3' do
      user.name = 'ee'
      user.should_not be_valid
    end

    it 'is unique' do
      other_user = FactoryGirl.create :user
      user.name = other_user.name
      user.should_not be_valid
    end
  end

  describe '#email' do
    it 'is required' do
      user.email = nil
      user.should_not be_valid
    end
  end

  describe '#date_of_birth' do
    it 'is required' do
      user.date_of_birth = nil
      user.should_not be_valid
    end

    it 'reffers to 13 years ago at least' do
      user.date_of_birth = 12.years.ago.to_date
      user.should_not be_valid
    end
  end

  describe '#gender' do
    it 'is required' do
      user.gender = nil
      user.should_not be_valid
    end

    it 'only accepts :male or :female as value' do
      user.gender = :female
      user.should be_valid
      user.gender = :male
      user.should be_valid
      user.gender = :lord_varys
      user.should_not be_valid
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
          user["#{field}_privacy"] = :public
          user.should be_valid
          user["#{field}_privacy"] = :only_me
          user.should be_valid
          user["#{field}_privacy"] = :friends
          user.should_not be_valid
        end

        it 'is required' do
          user["#{field}_privacy"] = nil
          user.should_not be_valid
        end
      end
    end
  end

  describe '#bio' do
    it 'has a maximum lenght of 500' do
      user.bio = 501.times.map{'e'}.join
      user.should_not be_valid
    end
  end

  describe "#status" do
    it 'is :active by default' do
      user = User.new
      user.status.should == :active
    end

    it 'only accepts :active or :blocked' do
      user.status = :active
      user.should be_valid
      user.status = :blocked
      user.should be_valid
      user.status = :banned
      user.should_not be_valid
    end

    it 'is required' do
      user.status = nil
      user.should_not be_valid
    end
  end

  it 'has an image uploader' do
    user.image.class.should == ImageUploader
  end

  describe '#location' do
    it 'has a maximum lenght of 200' do
      user.location = 201.times.map{'e'}.join
      user.should_not be_valid
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

  describe '::find_for_oauth' do
    context 'no user is given' do
      it 'returns the corresponding user if credentials are already in use'
      it 'returns a new user with the given credentials case no user have them' 
    end

    context 'an user is given' do
      it 'returns the same user given'
    end

    describe 'returned user' do
      it "is confirmed case it's valid"
      it 'has the given credentials and extra info'
    end
  end

  describe '::new_with_session' do
    it 'returns a new user'
    it 'adds the credentials and extra info of the devise session to the user created'
    it "does nothing case there's no oauth info in the devise session"
  end

  describe '#add_oauth_account' do
    it 'returns an account'
    it "returns a saved account case it's valid"
    it 'adds the account returned to the user'
    it 'fills the user with all extra info given'
  end

  describe '#role?' do
    it 'returns false if User does not have the given role' do
      user.roles.should_receive(:where).with(instance_of(Hash)).and_return([])
      user.role?(:baker).should be_false
    end

    it 'returns true if User has the given role' do
      user.roles.should_receive(:where).with(instance_of(Hash)).and_return([double('role')])
      user.role?(:baker).should be_true
    end
  end

  describe '#active?' do
    it 'returns true if the user is active' do
      user.status = :active
      user.active?.should be_true
    end

    it 'returns false if the user is not active' do
      user.status = :lazy
      user.active?.should be_false
    end
  end

  describe '#active_for_authentication?' do
    it 'returns false if the user is not active' do
      user.status = :lazy
      user.active_for_authentication?.should be_false
    end
  end
end
