class TagsIndex < Chewy::Index
  define_type ActsAsTaggableOn::Tag do
    field :name
  end
end

