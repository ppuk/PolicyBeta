require 'rails_helper'

describe Admin::PoliciesController, type: :controller do

  describe '#index' do
    let(:search_object) { double }
    let(:facets_object) { double }
    let(:policies) { double }
    let(:send_action) { get :index, search: { query: 'search term' } }

    before(:each) do
      allow(Request::Search::Policy).
        to receive(:search).
        and_return(search_object)

      allow(search_object).to receive(:facets).and_return(facets_object)
      allow(search_object).to receive(:search_with_facets).and_return(search_object)

      allow(PaginatedCollectionDecorator).
        to receive(:decorate).
        with(search_object).
        and_return(policies)
    end

    it_behaves_like 'admin restricted action' do
      let(:send_action) { get :index }
    end

    context 'with an admin user' do
      let(:admin) { build_stubbed(:admin) }

      before(:each) do
        sign_in_as admin
      end

      it 'should render succesfully' do
        send_action
        expect(response).to be_success
      end

      it 'should render the index template' do
        send_action
        expect(response).to render_template('index')
      end
    end
  end

end

