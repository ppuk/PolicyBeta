
shared_examples_for 'admin restricted action' do
  let(:user) { build_stubbed(:user) }

  it 'should redirect to sign in when not logged in' do
    send_action
    expect(response.status).to redirect_to(sign_in_path)
  end

  it 'should render missing when logged in as a user' do
    sign_in_as user
    send_action
    expect(response.status).to eql(404)
  end
end
