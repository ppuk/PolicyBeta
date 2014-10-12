FactoryGirl.define do

  POLICY_TAGS = %w(
    important
    priority
    discussion
    trivial
    rfc
  )

  factory :policy do
    title { Faker::Company.bs }
    description { Faker::HipsterIpsum.paragraphs(rand(3) + 1).join("\n") }
    submitter { create(:user, :with_confirmed_email) }
    category
    tag_list { POLICY_TAGS.sample(3).join(', ') }
    state { Policy::VALID_STATES.sample }


    trait :with_evidence do
      after(:build) do |policy|
        if policy.state == 'proposition'
          3.times do
            create(:evidence_item, :with_comments, policy: policy)
          end
        end
      end
    end


    trait :with_comments do
      after(:build) do |policy|
        3.times do
          create(:comment, :with_replies, commentable: policy)
        end
      end
    end
  end

end
