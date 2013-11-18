FactoryGirl.define do
  factory :topic  do
    sequence(:name)   {|n| "topic#{n}"}
    topic_type        'PUBLIC'
    user_id           0
  end
end
