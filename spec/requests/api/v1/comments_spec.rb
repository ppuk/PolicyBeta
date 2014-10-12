require 'rails_helper'

describe 'Comments', type: :request, vcr: true, tag: :api do
  let(:user) { create(:user) }
  let(:token) { get_valid_token(user) }

  let(:policy) { create(:policy, :with_comments) }

  describe 'GET index' do
    let(:response) { token.get("/api/v1/comments", params: request_params) }

    describe 'with no root id' do
      describe 'with a valid commentable object' do
        let(:request_params) { { commentable_id: policy.id, commentable_type: 'policy' } }

        it 'should render success' do
          expect(response.status).to eql(200)
        end

        it 'should render the comment thread' do
          comments = policy.comments.where(parent_comment_id: nil)
          serialized_comments = []
          comments.each do |comment|
            serialized_comments << comment_serialized_hash(comment)
          end

          expect(parsed_response[:comments]).to include(*serialized_comments)
        end

        it 'should render the meta data' do
          expect(parsed_response[:meta]).to include({
            page: 1,
            per_page: 25,
            total_items: policy.comments.where(parent_comment_id: nil).count
          })
        end
      end

      describe 'with an invalid commentable object' do
        let(:request_params) { { commentable_id: 0, commentable_type: 'policy' } }

        it 'should render missing' do
          expect(response.status).to eql(404)
        end
      end
    end

    describe 'with a root comment id' do
      let(:comment) { create(:comment, :with_replies, commentable: policy) }

      describe 'with a valid commentable object' do
        let(:request_params) { { commentable_id: policy.id, commentable_type: 'policy', root_id: comment.id } }

        it 'should render success' do
          expect(response.status).to eql(200)
        end

        it 'should render the comment thread' do
          comments = policy.comments.where(parent_comment_id: comment.id)
          serialized_comments = []
          comments.each do |comment|
            serialized_comments << comment_serialized_hash(comment)
          end

          expect(parsed_response[:comments]).to include(*serialized_comments)
        end

        it 'should render the meta data' do
          expect(parsed_response[:meta]).to include({
            page: 1,
            per_page: 25,
            total_items: policy.comments.where(parent_comment_id: comment.id).count
          })
        end
      end

      describe 'with an invalid commentable object' do
        let(:request_params) { { commentable_id: 0, commentable_type: 'policy', root_id: comment.id } }

        it 'should render missing' do
          expect(response.status).to eql(404)
        end
      end
    end
  end
end
