FactoryGirl.define do

  CATEGORY_NAMES = %w(
    finance
    transport
    copyright
    crime
    business
    development
  )

  CATEGORY_COLOURS = %w(
    #CA6E42
    #CABF42
    #52CA42
    #42CAA4
    #42A4CA
    #B442CA
    #CA427E
  )

  factory :category do
    name { CATEGORY_NAMES.sample }
    colour { CATEGORY_COLOURS.sample }

    initialize_with { Category.find_or_create_by(name: name)}

    trait :with_policies do
      after(:create) do |category|
        create(:policy, category: category)
      end
    end
  end

end
