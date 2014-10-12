module Features
  module CommentHelpers

    def comment_selector(comment)
      ".comment.comment_#{comment.id}"
    end

    def expect_page_not_to_have_comment(comment)
      expect(page).to_not have_css(comment_selector(comment))
    end

    def expect_page_to_have_comment(comment)
      selector = comment_selector(comment)

      expect(page).to have_css(selector)
      expect(page.find(selector)).to have_content(comment.body)
      expect(page.find(selector)).to have_content(comment.user.username)
      expect(page.find(selector)).to have_content(comment.user.username)
    end

    def click_load_replies_link_for(comment)
      within(comment_selector(comment)) do
        click_link "Load #{comment.replies.count} Replies"
      end
    end

  end
end
