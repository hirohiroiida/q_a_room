FactoryBot.define do
  factory :answer do
    body { "MyText" }
    user_id { 1 }
    question_id { 1 }
  end
end
