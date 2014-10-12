class CommentsIndex < Chewy::Index
  define_type Comment do
    field :body
    field :updated_at, type: 'date', include_in_all: false
    field :created_at, type: 'date', include_in_all: false
  end
end
