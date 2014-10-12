require 'rails_helper'

describe ErrorsController, type: :controller do

  describe '#show' do
    context 'with a valid error code 404' do
      let(:send_action) { get :show, status: 404 }

      it 'should render the template' do
        send_action
        expect(response).to render_template("errors/404")
      end

      it 'should return the code as the response status' do
        send_action
        expect(response.status).to eql(404)
      end
    end

    context 'with a valid error code 422' do
      let(:send_action) { get :show, status: 422 }

      it 'should render the template' do
        send_action
        expect(response).to render_template("errors/422")
      end

      it 'should return the code as the response status' do
        send_action
        expect(response.status).to eql(422)
      end
    end

    context 'with a valid error code 500' do
      let(:send_action) { get :show, status: 500 }

      it 'should render the template' do
        send_action
        expect(response).to render_template("errors/500")
      end

      it 'should return the code as the response status' do
        send_action
        expect(response.status).to eql(500)
      end
    end

    context 'with an invalid error code' do
      let(:send_action) { get :show, status: 999  }

      it 'should raise a runtime exception' do
        expect {
          send_action
        }.to raise_exception(RuntimeError)
      end
    end
  end

end
