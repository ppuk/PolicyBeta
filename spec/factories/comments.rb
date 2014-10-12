FactoryGirl.define do

  factory :comment do
    commentable { create(:policy) }
    body { Faker::Lorem.paragraph }
    user

    ignore do
      comment_levels 0
      comments_per_level 3
    end

    trait :with_replies do
      comment_levels 2
    end

    after(:build) do |comment, evaluator|
      if evaluator.comment_levels > 0
        evaluator.comments_per_level.times do
          create(
            :comment,
            parent_comment: comment,
            commentable: comment.commentable,
            comment_levels: evaluator.comment_levels - 1
          )
        end
      end
    end
  end

end
