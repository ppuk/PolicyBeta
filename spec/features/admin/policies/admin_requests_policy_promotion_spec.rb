require 'rails_helper'

feature 'Requesting a policy promotion as an admin', vcr: true do
  let!(:policy) { create(:policy, state: 'suggestion') }

  scenario 'user accepts promotion' do
    login_as_admin
    visit policy_path(policy)

    expect(page).to have_content('Request Promotion')
    click_link 'Request promotion'

    expect(page).to have_content('Promotion Requested')
    sign_out

    # A notification email should be sent to the submitter
    open_email policy.submitter.email
    expect(current_email).to_not be_nil
    expect(current_email.subject).to eql('Promotion requested')

    # Submitter clicks link in email and accepts the promotion
    login_as policy.submitter
    visit policy_path(policy)

    expect(page).to have_content('Confirm Promotion')
    click_link 'Approve'

    # Email is sent to the admins
    open_email User.where(role: 'admin').first.email
    expect(current_email).to_not be_nil
    expect(current_email.subject).to eql('Promotion granted')

    # Policy is promoted
    visit policy_path(policy)
    expect(page).to have_content('Proposition')
  end

  scenario 'user rejects promotion' do
    login_as_admin
    visit policy_path(policy)

    expect(page).to have_content('Request Promotion')
    click_link 'Request promotion'

    expect(page).to have_content('Promotion Requested')
    sign_out

    # A notification email should be sent to the submitter
    open_email policy.submitter.email
    expect(current_email).to_not be_nil
    expect(current_email.subject).to eql('Promotion requested')

    # Submitter clicks link in email and accepts the promotion
    login_as policy.submitter
    visit policy_path(policy)

    expect(page).to have_content('Confirm Promotion')
    click_link 'Reject'

    # Email is sent to the admins
    open_email User.where(role: 'admin').first.email
    expect(current_email).to_not be_nil
    expect(current_email.subject).to eql('Promotion declined')

    # Policy is promoted
    visit policy_path(policy)
    expect(page).to have_content('Suggestion')
  end

end
