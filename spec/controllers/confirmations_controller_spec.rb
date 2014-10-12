require 'rails_helper'

describe ConfirmationsController, type: :controller do

  describe 'GET show' do
    let(:send_action) { get :show, id: 1, token: 'token' }
    let(:confirmer) { double }


    it 'should call the confirmer' do
      expect(Service::User::Confirm).
        to receive(:new).
        with({'id' => '1', 'token' => 'token'}).
        and_return(confirmer)

      expect(confirmer).to receive(:perform).and_return(true)

      send_action
    end

    describe 'rendering' do
      before(:each) do
        allow(Service::User::Confirm).to receive(:new).and_return(confirmer)
        allow(confirmer).to receive(:perform).and_return(true)
      end

      context 'with valid confirmation params' do
        before(:each) do
          allow(confirmer).to receive(:success?).and_return(true)
        end

        it 'should render the email_confirmed template' do
          send_action
          expect(response).to render_template('email_confirmed')
        end
      end

      context 'with invalid confirmation params' do
        before(:each) do
          allow(confirmer).to receive(:perform).and_return(false)
        end

        it 'should render the email_not_confirmed template' do
          send_action
          expect(response).to render_template('email_not_confirmed')
        end
      end
    end
  end

end
