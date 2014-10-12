class PoliciesIndex < Chewy::Index
  define_type Policy.includes(:category, :tags) do
    field :title
    field :description
    field :submitter_id
    field :state
    field :category, value: ->(policy) { policy.category.name }
    field :cached_votes_score, type: 'integer', include_in_all: false
    field :tags, index: 'not_analyzed', value: ->(policy) { policy.tags.map(&:name) }
    field :updated_at, type: 'date', include_in_all: false
    field :created_at, type: 'date', include_in_all: false
  end
end

