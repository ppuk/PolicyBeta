require 'rails_helper'

describe 'My Profile', type: :request, tag: :api, vcr: true do
  let(:token) { get_valid_token(user) }

  describe 'GET show' do
    let(:response) { token.get("/api/v1/profile") }

    [:user].each do |user_type|
      context "with a #{user_type.to_s}" do
        let(:user) { create(user_type) }

        it 'should render successfully' do
          expect(response.status).to eql(200)
        end

        it 'should render my profile' do
          expect(parsed_response).to eql(
            profile: profile_serialized_hash(user)
          )
        end
      end
    end
  end


  describe 'PUT update' do
    let(:response) { token.put("/api/v1/profile", params: { user: request_params }) }

    [:user, :admin].each do |user_type|
      context "with a #{user_type.to_s}" do
        let(:user) { create(user_type) }

        context 'with valid params' do
          let(:request_params) { { email: 'changed@example.com' } }

          it 'should render success' do
            expect(response.status).to eql(200)
          end

          it 'should update my profile' do
            expect {
              response
              user.reload
            }.to change(user, :email).to('changed@example.com')
          end

          it 'should render the updated profile' do
            response
            user.reload

            expect(parsed_response).to eql(
              profile: profile_serialized_hash(user)
            )
          end
        end

        context 'with invalid params' do
          let(:request_params) { {email: 'invalid'} }

          it 'should respond as unprocessable' do
            expect(response.status).to eql(422)
          end

          it 'should not change my profile' do
            expect {
              response
              user.reload
            }.not_to change(user, :email)
          end

          it 'should render the error messages' do
            expect(parsed_response[:errors]).not_to be_empty
            expect(parsed_response[:errors]).to eql([
              { email: "invalid" },
            ])
          end
        end
      end
    end

  end
end

