FactoryBot.define do
  factory :council do
    
    user
    sequence(:title) { |n| "title#{n}" }
    description 'a' * 20
    
  end
end
