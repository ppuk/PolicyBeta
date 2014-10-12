class UsersIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      email: {
        tokenizer: 'keyword',
        filter: ['lowercase']
      }
    }
  }

  define_type User do
    field :username
    field :email, analyzer: 'email'
    field :updated_at, type: 'date', include_in_all: false
    field :created_at, type: 'date', include_in_all: false
  end
end
