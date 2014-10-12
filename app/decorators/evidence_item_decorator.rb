class EvidenceItemDecorator < BaseDecorator
  decorates_association :submitter

  def approved_state
    scope = 'activerecord.attributes.evidence_item'
    object.accepted ? I18n.t('approved', scope: scope) : I18n.t('not_approved', scope: scope)
  end
end
