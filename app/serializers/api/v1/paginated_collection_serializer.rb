class Api::V1::PaginatedCollectionSerializer < ActiveModel::ArraySerializer

  def initialize(object, options={})
    raise 'This requires a paginated collection' unless object.respond_to?(:current_page)

    super
  end

  def meta_key
    :meta
  end

  def include_meta(hash)
    hash[meta_key] = {
      total_items: object.total_count,
      page: object.current_page,
      per_page: object.limit_value
    }
  end

end
