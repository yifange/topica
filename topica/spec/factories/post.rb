FactoryGirl.define do
  factory :post  do
    sequence(:title)  {|n| "TestTitle#{n}"}
    content           {MySpecUtils.random_string 100}
  end
end
