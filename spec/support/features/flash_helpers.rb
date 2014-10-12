module Features
  module FlashHelpers

    def should_display_flash(flash_type, message)
      expect(find("div.alert.alert-#{flash_type}.flash")).to have_content(message)
    end

  end
end
