class Api::V1::BaseSerializer < ActiveModel::Serializer
  delegate :current_user, to: :scope

  def created_at
    object.created_at.utc.iso8601 if object.created_at
  end

  def updated_at
    object.updated_at.utc.iso8601 if object.updated_at
  end
end
