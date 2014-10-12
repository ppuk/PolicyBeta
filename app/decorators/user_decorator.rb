class UserDecorator < BaseDecorator
  def logged_in_display_name
    object.username
  end

  def display_role
    scope = 'activerecord.helpers.user.roles'

    if object.role.blank?
      return ''
    end

    if object.deleted?
      I18n.t('deleted', scope: scope)
    else
      I18n.t(object.role, scope: scope)
    end
  end


  def display_state_class
    return 'danger' if object.deleted?
    return 'warning' if object.banned?
    'default'
  end

  def display_state
    state = :active
    state = :banned if object.banned?
    state = :deleted if object.deleted?
    I18n.t(state, scope: 'activerecord.helpers.user.state')
  end

  def confirmed_state
    confirmed_class = object.email_confirmed? ? 'check' : 'close'
    h.content_tag(:i, '', class: "email_confirm_state fa fa-#{confirmed_class}")
  end

  def email_confirmed_on
    if object.email_confirmed?
      l(object.email_confirmed_on, format: :admin)
    else
      I18n.t('not_confirmed', scope: 'activerecord.helpers.user')
    end
  end

  def email_confirmation_line
    confirmed_state + ' ' + email_confirmed_on
  end
end
