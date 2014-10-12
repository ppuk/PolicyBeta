require 'rails_helper'


feature 'commenting on a policy', js: true do
  let!(:policy) { create(:policy, state: 'suggestion') }
  let!(:user) { create(:user) }

  before(:each) do
    login_as user
  end

  scenario 'adding a root comment' do
    visit policy_path(policy)

    within('.comments .comment_form') do
      find('textarea').set('a new comment')
      find('.btn.btn-success').click
    end

    within('.comments .comment_form') do
      expect(find('textarea').value).to be_blank
    end

    expect(page).to have_content('a new comment')
  end


  scenario 'adding a reply to a comment that has no replies' do
    create(:comment, commentable: policy)
    visit policy_path(policy)

    expect(page).to have_content(policy.comments.from_root(nil).first.body)

    within('.comments ul.comment_thread') do
      expect(page).to_not have_selector('.comment_form')

      within('li.comment:first-child .comment-data') do
        click_link('Reply')
      end

      expect(page).to have_selector('.comment_form')

      within('.comment_form') do
        find('textarea').set('a reply to a comment')
        find('.btn.btn-success').click
      end

      expect(page).to have_content('a reply to a comment')
    end
  end


  scenario 'adding a reply to a comment that already has replies' do
    create(:comment, :with_replies, commentable: policy)
    visit policy_path(policy)

    expect(page).to have_content(policy.comments.from_root(nil).first.body)

    within('.comments ul.comment_thread') do
      expect(page).to_not have_selector('.comment_form')

      within('li.comment:first-child .comment-data') do
        click_link('Load 3 Replies')
        click_link('Reply')
      end

      expect(page).to have_selector('.comment_form')

      within('.comment_form') do
        find('textarea').set('a reply to a comment')
        find('.btn.btn-success').click
      end

      expect(page).to have_content('a reply to a comment')
    end
  end
end
