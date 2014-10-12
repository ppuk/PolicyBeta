require 'rails_helper'

feature 'Accepting a policy as an admin', vcr: true do
  let!(:policy) { create(:policy, state: 'vote') }

  scenario 'with access' do
    login_as_admin
    visit admin_policy_path(policy)

    click_link 'Accept'

    should_display_flash(:success, 'Policy accepted')

    policy.reload
    expect(policy.state).to eql('passed')
    expect(Policy.last.previous_version).to eql(policy)

    # A notification email should be sent
    open_email policy.submitter.email
    expect(current_email).to_not be_nil
    expect(current_email.subject).to eql('Policy accepted')
  end

end

