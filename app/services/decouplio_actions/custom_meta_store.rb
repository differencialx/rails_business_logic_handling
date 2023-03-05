module DecouplioActions
  class CustomMetaStore
    attr_accessor :semantic, :errors

    def initialize
      @errors = []
    end

    def to_s
      <<~METASTORE
        Semantic:
          #{semantic.inspect}
        Errors:
          #{errors.empty? ? 'No errors' : errors.inspect}
      METASTORE
    end
  end
end
