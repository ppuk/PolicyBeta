require 'rails_helper'

describe Api::V1::CommentVoteSerializer, tag: :api do
  let(:scope) { double current_user: voter }
  let(:subject) { described_class.new(vote, scope: scope) }

  let(:submitter) { build_stubbed(:user) }
  let(:voter) { build_stubbed(:user) }
  let(:comment) { build_stubbed(:comment) }
  let(:vote) { build_stubbed(:vote, voter: voter, votable: comment) }

  describe '.to_json' do
    it 'should render correctly' do
      expect(subject.as_json).to eql({
        vote: {
          vote_flag: vote.vote_flag,
          votable: comment_serialized_hash(comment),
          voter: profile_serialized_hash(voter)
        }
      })
    end
  end
end


