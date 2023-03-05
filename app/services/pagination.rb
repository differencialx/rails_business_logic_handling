class Pagination
  include Pagy::Backend

  def self.call(...)
    new(...).call
  end

  def initialize(scope:, options:)
    @scope = scope
    @options = options
  end

  def call
    pagy_meta, records = pagy(@scope, items: @options[:items])
    pagy_meta = {
      count: pagy_meta.count,
      page: pagy_meta.page,
      items: pagy_meta.items,
      last: pagy_meta.last,
      pages: pagy_meta.pages
    }

    [pagy_meta, records]
  end

  private

  def pagy_get_vars(scope, vars)
    pagy_set_items_from_params(vars) if defined?(ItemsExtra)
    vars[:count] ||= (count = @scope.count(:all)).is_a?(Hash) ? count.size : count
    vars[:page] = @options[:page]
    vars
  end
end
