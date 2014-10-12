Dir[Rails.root.join('spec/support/features/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include Features::ClearanceHelpers, type: :feature
  config.include Features::ResponseHelpers, type: :feature
  config.include Features::AdminHelpers, type: :feature
  config.include Features::FlashHelpers, type: :feature
  config.include Features::AccessDenialHelpers, type: :feature
  config.include Features::AjaxHelpers, type: :feature
  config.include Features::CommentHelpers, type: :feature

  # For the faceted search, we need to ensure we have all categories
  # generated as we're using VCR, not a live ES instance for testing
  config.before(:each) do
    CATEGORY_NAMES.each do |category_name|
      create(:category, name: category_name)
    end
  end
end
