FactoryGirl.define do
  salt = "asdasdastr4325234324sdfds"
  factory :user do
    sequence(:username)   {|n| "username#{n}"}
    email                 {"#{username}email@example.com"}
    password              "secret"
    password_confirmation "secret"
    #crypted_password      Sorcery::CryptoProviders::BCrypt.encrypt("secret", salt)
    #salt                  salt
    name                  {username}
  end
end
