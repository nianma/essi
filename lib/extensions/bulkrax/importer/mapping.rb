module Extensions
  module Bulkrax
    module Importer
      module Mapping
        # modified from bulkrax to merge configured mapping into default, instead of overriding
        def mapping
          return @mapping if @mapping.present?
          @mapping = default_mapping
          # change default split (false) to custom regexp
          @mapping.keys.each do |k|
            @mapping[k][:split] = /\s*[;|]\s*/ # default split by ; |
          end
          self.field_mapping&.each do |k, v|
            if v.is_a? Hash
              @mapping[k] ||= {}.with_indifferent_access
              @mapping[k] = @mapping[k].merge(v)
            else
              @mapping[k] = v
            end
          end
          @mapping
        end

        def default_mapping(properties = parser.import_fields)
          properties&.reject!(&:nil?)
          return {}.with_indifferent_access unless properties&.any?
          properties.map do |m|
            ::Bulkrax.default_field_mapping.call(m).with_indifferent_access
          end.inject(:merge).with_indifferent_access
        end
      end
    end
  end
end
