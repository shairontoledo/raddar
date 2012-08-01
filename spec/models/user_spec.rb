require 'spec_helper'

describe User do
  subject { FactoryGirl.build :user }

  it { should be_valid }

  it { should be_a_raddar_model }
  it { should be_followable }
  it { should be_searchable }

  it { should have_slug(:name) }

  describe '#name' do
    it 'is required' do
      should validate_presence_of(:name)
    end

    it 'accepts only numbers, letters and _' do
      should validate_format_of(:name).with_format(/^(([a-z]|[A-Z]|[0-9]|_)+)$/)
    end

    it 'has a maximum lenght of 20' do
      should validate_length_of(:name).with_maximum(20)
    end

    it 'has a minimum lenght of 3' do
      should validate_length_of(:name).with_minimum(3)
    end

    it 'is unique' do
      should validate_uniqueness_of(:name)
    end
  end

  describe '#email' do
    it 'is required' do
      should validate_presence_of(:email)
    end
  end

  describe '#date_of_birth' do
    it 'is required' do
      should validate_presence_of(:date_of_birth)
    end

    it 'reffers to 13 years ago at least' do
      subject.date_of_birth = 12.years.ago.to_date
      should_not be_valid
    end
  end

  describe '#gender' do
    it 'is required' do
      should validate_presence_of(:gender)
    end

    it 'only accepts :male or :female as value' do
      should validate_inclusion_of(:gender).to_allow([:male, :female])
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
          should validate_inclusion_of(:"#{field}_privacy").to_allow([:public, :only_me])
        end
      end
    end
  end

  describe '#bio' do
    it 'has a maximum lenght of 500' do
      should validate_length_of(:bio).with_maximum(500)
    end
  end

  describe "#status" do
    it 'is :active by default' do
      user = User.new
      user.status.should == :active
    end

    it 'only accepts :active or :blocked' do
      should validate_inclusion_of(:status).to_allow([:active, :blocked])
    end

    it 'is required' do
      should validate_presence_of(:status)
    end
  end

  it 'has an image uploader' do
    subject.image.class.should == ImageUploader
  end

  describe '#location' do
    it 'has a maximum lenght of 200' do
      should validate_length_of(:location).with_maximum(200)
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
      subject.roles.should_receive(:where).with(instance_of(Hash)).and_return([])
      subject.role?(:baker).should be_false
    end

    it 'returns true if User has the given role' do
      subject.roles.should_receive(:where).with(instance_of(Hash)).and_return([double('role')])
      subject.role?(:baker).should be_true
    end
  end

  describe '#active?' do
    it 'returns true if the user is active' do
      subject.status = :active
      subject.active?.should be_true
    end

    it 'returns false if the user is not active' do
      subject.status = :lazy
      subject.active?.should be_false
    end
  end

  describe '#active_for_authentication?' do
    it 'returns false if the user is not active' do
      subject.status = :lazy
      subject.active_for_authentication?.should be_false
    end
  end
end
