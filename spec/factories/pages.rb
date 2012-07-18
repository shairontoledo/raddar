# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    sequence :name do |n|
      "Sample Page #{n}"
    end

    title 'This is a title'
    content 'This is a content'
  end
end
