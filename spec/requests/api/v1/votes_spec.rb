require 'rails_helper'

describe 'Votes', type: :request, vcr: true, tag: :api do
  let(:user) { create(:user) }
  let(:token) { get_valid_token(user) }

  describe 'POST create' do
    let(:response) { token.post("/api/v1/votes", params: request_params) }

    describe 'with a valid object to vote on' do
      let(:policy) { create(:policy) }
      let(:request_params) { { id: policy.id, type: 'policy', upvote: true } }

      describe 'a valid new vote' do
        it 'should be a success' do
          expect(response.status).to eql(200)
        end

        it 'should register my vote' do
          expect(parsed_response[:vote][:vote_flag]).to be_truthy
        end

        it 'should render the updated vote count for the votable object' do
          expect(parsed_response[:vote][:votable][:votes_score]).to eql(1)
        end
      end

      describe 'voting the same twice' do
        before(:each) do
          token.post("/api/v1/votes", params: request_params)
        end

        it 'should be a success' do
          expect(response.status).to eql(200)
        end

        it 'should clear my vote' do
          expect(parsed_response[:vote][:vote_flag]).to be_nil
        end

        it 'should render the updated vote count for the votable object' do
          expect(parsed_response[:vote][:votable][:votes_score]).to eql(0)
        end
      end

      describe 'changing my vote' do
        before(:each) do
          token.post("/api/v1/votes", params: { id: policy.id, type: 'policy', upvote: true })
        end

        let(:request_params) { { id: policy.id, type: 'policy', upvote: false } }

        it 'should be a success' do
          expect(response.status).to eql(200)
        end

        it 'should register my vote' do
          expect(parsed_response[:vote][:vote_flag]).to be_falsey
        end

        it 'should render the updated vote count for the votable object' do
          expect(parsed_response[:vote][:votable][:votes_score]).to eql(-1)
        end
      end
    end

    describe 'with an invalid object type to vote on' do
      let(:request_params) { { id: 1, type: 'invalid' } }

      it 'should render 422' do
        expect(response.status).to eql(422)
      end
    end

    describe 'with an invalid object id to vote on' do
      let(:request_params) { { id: 1, type: 'policy' } }

      it 'should render 404' do
        expect(response.status).to eql(404)
      end
    end
  end

end
