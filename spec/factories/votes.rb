FactoryGirl.define do

  factory :vote, class: ActsAsVotable::Vote do
    votable { create(:policy) }
    voter { create(:user) }
    vote_flag { [true, false].sample }
  end

end

