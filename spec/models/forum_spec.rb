require 'spec_helper'

describe Forum do
  subject do
    FactoryGirl.build :forum
  end

  it { should be_valid }

  it { should be_a_raddar_model }
  it { should be_followable }
  it { should be_searchable }

  it { should have_slug(:name) }

  it { should have_many(:topics)}
  it { should belong_to(:universe)}

  it { should validate_presence_of(:name)}
  it { should validate_length_of(:name).with_maximum(100)}

  it { should validate_presence_of(:description)}
  it { should validate_length_of(:description).with_maximum(500)}


  describe '#last_topics' do
    it 'returns its topics ordered by the descendent update date' do
      subject.topics.should_receive(:order_by).with([:updated_at, :desc])
      subject.last_topics
    end
  end

  
  context 'when it has topics' do
    subject { FactoryGirl.create :forum_with_topics }

    it 'cannot be destroyed' do
      subject.destroy.should be_false
    end

    it 'gets an error on base when attempting to destroy' do
      subject.destroy
      subject.errors[:base].should_not be_empty
    end
  end

  context 'when it has no topics' do
    it 'can be destroyed' do
      subject.destroy.should be_true
    end
  end

end
