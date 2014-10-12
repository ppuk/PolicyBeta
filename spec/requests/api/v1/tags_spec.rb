require 'rails_helper'

describe 'Tags', type: :request, vcr: true, tag: :api do
  let(:user) { create(:user) }
  let(:token) { get_valid_token(user) }

  describe 'searching for typeahead' do
    let(:request_params) { { query: 'te' } }
    let(:response) { token.get("/api/v1/tags", params: request_params) }
    let(:parsed_response) { response.parsed.with_indifferent_access }

    before(:each) do
      create(:policy, tag_list: 'something, test, testing, tester')
    end

    it 'should return the matching tags' do
      expect(parsed_response[:tags]).to_not include({"tags" => {"id" => 1, "name" => "something", "taggings_count" => 1}})
      expect(parsed_response[:tags]).to include({"tags" => {"id" => 2, "name" => "test", "taggings_count" => 1}})
      expect(parsed_response[:tags]).to include({"tags" => {"id" => 3, "name" => "testing", "taggings_count" => 1}})
      expect(parsed_response[:tags]).to include({"tags" => {"id" => 4, "name" => "tester", "taggings_count" => 1}})
    end
  end
end

