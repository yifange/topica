FactoryGirl.define do
  factory :comment  do
    post_id           0
    user_id           0
    content           {MySpecUtils.random_string 100} 
  end
end
