FactoryGirl.define do
  sequence(:email) {|n| "user_#{n}@example.com" }

  factory :user do
    password "password"
    sequence(:username) {|n| "username_#{n}"}
    role 'user'

    trait :with_email do
      email
    end

    trait :with_confirmed_email do
      email

      after(:create) do |user|
        user.confirm_email!
      end
    end

    trait :with_ip_logs do
      after(:build) do |user|
        rand(10).times do
          create(:ip_log, user: user)
        end
      end
    end

    trait :banned do
      banned_until { 1.day.from_now }
    end

    trait :expired_ban do
      banned_until { 1.day.ago }
    end

    trait :deleted do
      deleted_at { 1.day.ago.utc }
    end

    trait :with_submitted_policies do
      after(:build) do |user|
        rand(3).times do
          create(:policy, :with_comments, :with_evidence, submitter: user)
        end
      end
    end
  end

  factory :admin, parent: :user do
    sequence(:email) {|n| "admin_#{n}@example.com" }
    role 'admin'

    after(:create) do |user|
      user.confirm_email!
    end
  end

end

