FactoryGirl.define do

  factory :evidence_item do
    title { Faker::Company.bs }
    description { Faker::HipsterIpsum.paragraphs(rand(3) + 1).join("\n") }
    submitter { create(:user, :with_confirmed_email) }

    trait :with_comments do
      after(:build) do |evidence_item|
        3.times do
          create(:comment, :with_replies, commentable: evidence_item)
        end
      end
    end
  end

end
