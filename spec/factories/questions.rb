FactoryBot.define do
  factory :question do
    title { 'MyString' }
    body { 'MyText' }
    solved { false }
    user_id { 1 }
  end
end
