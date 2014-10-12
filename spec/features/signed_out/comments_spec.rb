require 'rails_helper'


feature 'voting on comments when signed out', js: true do
  let!(:policy) { create(:policy) }
  let!(:comment_1)   { create(:comment, commentable: policy) }

  it 'should display the vote counts' do
    visit policy_path(policy.id)
    expect_page_to_have_comment(comment_1)

    within comment_selector(comment_1) do
      expect(find('.vote_state .vote_total')).to have_content('0')
    end
  end

  it 'should ask the user to sign in when voting' do
    visit policy_path(policy.id)
    expect_page_to_have_comment(comment_1)

    within comment_selector(comment_1) do
      find('a.upvote').click
      alert = page.driver.browser.switch_to.alert
      expect(alert.text).to eql('Please log in first')
      alert.dismiss
    end
  end
end

feature 'viewing comments when signed out', js: true do
  let!(:policy) { create(:policy) }

  let!(:comment_1)   { create(:comment, commentable: policy) }
  let!(:comment_1_1) { create(:comment, commentable: policy, parent_comment: comment_1) }
  let!(:comment_1_2) { create(:comment, commentable: policy, parent_comment: comment_1) }
  let!(:comment_2)   { create(:comment, commentable: policy) }

  it 'should display comment replies' do
    visit policy_path(policy.id)
    expect_page_to_have_comment(comment_1)
    expect_page_to_have_comment(comment_2)
    expect_page_not_to_have_comment(comment_1_1)
    expect_page_not_to_have_comment(comment_1_2)
  end

  it 'should load nested comments when link is clicked' do
    visit policy_path(policy.id)
    expect_page_to_have_comment(comment_1)
    expect_page_not_to_have_comment(comment_1_1)
    expect_page_not_to_have_comment(comment_1_2)

    click_load_replies_link_for(comment_1)

    expect_page_to_have_comment(comment_1_1)
    expect_page_to_have_comment(comment_1_2)
  end

  it 'should link the user to the sign up page to comment' do
    visit policy_path(policy.id)

    expect(page).to have_content('Log in to comment')
    find_link('Log in to comment').click

    expect(current_path).to eq(sign_in_path)
  end

  it 'should not display any reply links' do
    visit policy_path(policy.id)
    expect(page).to_not have_content('Reply')
  end

end
