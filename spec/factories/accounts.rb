# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account do
    user
    provider :my_social_network
    sequence :token do |n|
      "xxyyzz#{n}aabbcc"
    end
    sequence :name do |n|
      "user#{n}"
    end
    url { "http://#{provider}.net/#{name}" }
    url_privacy :public
  end
end
