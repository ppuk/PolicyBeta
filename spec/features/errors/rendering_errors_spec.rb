require 'rails_helper'

feature 'Rendering error pages' do

  scenario 'on 404' do
    visit '/404'
    expect(page).to have_content('Page Missing')
    expect(page.status_code).to eql(404)
  end

  scenario 'on 422' do
    visit '/422'
    expect(page).to have_content('Invalid Request')
    expect(page.status_code).to eql(422)
  end

  scenario 'on 500' do
    visit '/500'
    expect(page).to have_content('Internal Error')
    expect(page.status_code).to eql(500)
  end
end
