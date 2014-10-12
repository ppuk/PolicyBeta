module Features
  module ResponseHelpers

    def page_should_display_missing
      expect(page.body).to include(
        I18n.t('.title', scope: 'errors.404')
      )
    end

    def page_should_redirect_to_sign_in
      expect(page.body).to include('Sign in')
      expect(current_path).to eql(sign_in_path)
    end

  end
end
