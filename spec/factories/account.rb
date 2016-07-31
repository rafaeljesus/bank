FactoryGirl.define do
  factory :account, class: Bank::Entity::Account do
    name 'City Bank'
    balance 9.99
    user
  end
end
