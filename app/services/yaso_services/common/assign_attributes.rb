module YasoServices
  module Common
    class AssignAttributes
      def self.call(ctx)
        ctx[:model].assign_attributes(ctx[:params].merge(image_url: ctx[:image_url]))
        true
      end
    end
  end
end
