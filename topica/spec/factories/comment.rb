FactoryGirl.define do
  factory :comment  do
    post_id           0
    user_id           0
    content           {(0...100).map { (65 + rand(26)).chr }.join}
  end
end
