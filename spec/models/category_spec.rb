require 'rails_helper'

describe Category, type: :model, vcr: true do
  describe "validations" do
    let!(:category) { create(:category) }

    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
  end
end

