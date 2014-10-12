require 'rails_helper'

describe Policy, type: :model, vcr: true do
  describe "validations" do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :submitter }
    it { is_expected.to validate_presence_of :category }
  end
end
