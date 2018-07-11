FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "title#{n}" }
    content 'a' * 20    
	user
	council
  end
end
