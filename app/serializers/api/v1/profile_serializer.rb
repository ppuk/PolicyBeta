class Api::V1::ProfileSerializer < Api::V1::BaseSerializer
  attributes :id, :email, :username,  :role

  def role
    object.is_admin? ? 'admin' : 'user'
  end
end
