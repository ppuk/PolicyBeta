require 'rails_helper'

describe Api::V1::CommentSerializer, tag: :api do
  let(:scope) { double current_user: user }
  let(:subject) { described_class.new(comment, scope: scope) }

  let(:user) { build_stubbed(:user) }
  let(:comment) { build_stubbed(:comment, user: user) }

  describe '.to_json' do
    it 'should render correctly' do
      expect(subject.as_json).to eql({
        comment: comment_serialized_hash(comment)
      })
    end
  end
end



