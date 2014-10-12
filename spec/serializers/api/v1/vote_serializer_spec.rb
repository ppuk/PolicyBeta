require 'rails_helper'

describe Api::V1::VoteSerializer, tag: :api do
  let(:subject) { described_class.new(vote) }

  let(:submitter) { build_stubbed(:user) }
  let(:voter) { build_stubbed(:user) }
  let(:vote) { build_stubbed(:vote, voter: voter) }

  describe '.to_json' do
    it 'should render correctly' do
      expect(subject.as_json).to eql({
        vote: {
          vote_flag: vote.vote_flag,
          voter: serialized_user_profile(voter)
        }
      })
    end
  end

  def serialized_user_profile(user)
    {
      id: user.id,
      email: user.email,
      username: user.username,
      role: user.role
    }
  end
end


