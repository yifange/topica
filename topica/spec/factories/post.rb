FactoryGirl.define do
  factory :post  do
    user_id           0
    sequence(:title)  {|n| "TestTitle#{n}"}
    content           {MySpecUtils.random_string 100}
  end
end
