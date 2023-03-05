module TrailblazerOperations
  module Cats
    class IndexWithMacro < Trailblazer::Operation
      step TrailblazerOperations::Macros::Validate(::Cats::Reform::Index), fast_track: true
      step TrailblazerOperations::Macros::InitScope(model: Cat, scope: :all, to_key: :model)
      step TrailblazerOperations::Macros::Query(::Cats::IndexQuery, scope_key: :model, query_params_key: :params)
      step TrailblazerOperations::Macros::Paginate()
      step TrailblazerOperations::Macros::Decorate()
    end
  end
end
