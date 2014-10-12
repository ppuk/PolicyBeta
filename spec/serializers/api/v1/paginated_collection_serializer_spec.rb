require 'rails_helper'

describe Api::V1::PaginatedCollectionSerializer, tag: :api do
  let(:paginated_collection) { Kaminari.paginate_array([1, 2, 3, 4, 5], total_count: 5).page(2).per(2) }
  subject { described_class.new(paginated_collection, root: :data) }

  describe '.initialize' do
    it 'should require a paginated collection' do
      expect {
        described_class.new([])
      }.to raise_error
    end
  end

  describe '.to_json' do
    it 'should add the metadata' do
      expect(subject.as_json[:meta]).to eql({
        total_items: 5,
        page: 2,
        per_page: 2
      })
    end
  end

end
