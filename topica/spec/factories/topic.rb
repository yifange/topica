FactoryGirl.define do
  factory :topic  do
    sequence(:name)   {|n| "topic#{n}"}
    topic_type        0
    user_id           0
  end
end
