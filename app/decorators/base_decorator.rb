class BaseDecorator < Draper::Decorator
  delegate_all

  def created_at
    l(object.created_at, format: :admin)
  end
end

