FactoryGirl.define do
  factory :post  do
    #user_id           0
    #topic_id          0
    sequence(:title)  {|n| "TestTitle#{n}"}
    content           {(0...100).map { (65 + rand(26)).chr }.join}
  end
end
