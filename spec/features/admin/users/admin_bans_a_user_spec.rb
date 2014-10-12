require 'rails_helper'

feature 'Banning a user as an admin', vcr: true do
  let!(:user) { create(:user) }

  scenario 'with access' do
    expect(user.banned?).to eql(false)
    login_as_admin
    visit edit_admin_user_path(user)

    date = 1.day.from_now
    find('#user_banned_until').set(date.iso8601)
    click_button 'Save changes'

    should_display_flash(:success, 'User updated')
    expect(page).to have_content(I18n.l(date.localtime, format: :admin))

    user.reload
    expect(user.banned?).to eql(true)
  end
end
