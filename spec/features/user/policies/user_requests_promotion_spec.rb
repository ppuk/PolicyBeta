require 'rails_helper'

feature 'Requesting a policy promotion as a user', vcr: true do
  let!(:policy) { create(:policy, state: 'suggestion') }
  let(:user) { policy.submitter }
  let!(:admin) { create(:admin) }

  scenario 'admin accepts promotion' do
    login_as user
    visit policy_path(policy)

    expect(page).to have_content('Request Promotion')
    click_link 'Request promotion'

    expect(page).to have_content('Promotion Requested')
    sign_out

    # A notification email should be sent to the admin
    open_email admin.email
    expect(current_email).to_not be_nil
    expect(current_email.subject).to eql('Promotion requested')

    # Admin clicks link in email and accepts the promotion
    login_as admin
    visit policy_path(policy)

    expect(page).to have_content('Confirm Promotion')
    click_link 'Approve'

    # Email is sent to the user
    open_email user.email
    expect(current_email).to_not be_nil
    expect(current_email.subject).to eql('Promotion granted')

    # Policy is promoted
    visit policy_path(policy)
    expect(page).to have_content('Proposition')
  end

  scenario 'user rejects promotion' do
    login_as user
    visit policy_path(policy)

    expect(page).to have_content('Request Promotion')
    click_link 'Request promotion'

    expect(page).to have_content('Promotion Requested')
    sign_out

    # A notification email should be sent to the admin
    open_email admin.email
    expect(current_email).to_not be_nil
    expect(current_email.subject).to eql('Promotion requested')

    # Admin clicks link in email and accepts the promotion
    login_as admin
    visit policy_path(policy)

    expect(page).to have_content('Confirm Promotion')
    click_link 'Reject'

    # Email is sent to the user
    open_email user.email
    expect(current_email).to_not be_nil
    expect(current_email.subject).to eql('Promotion declined')

    # Policy is promoted
    visit policy_path(policy)
    expect(page).to have_content('Suggestion')
  end

end
