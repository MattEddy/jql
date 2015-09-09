module JsonQL
  class Condition < Proc
    def self.create_from_tokens(tokens)
      instance = new { |table|
        set_variables = (available_keys(table) & tokens).map do |required_datum|
          if table[required_datum]
            required_datum + convert_type_if_needed(table[required_datum])
          end
        end

        eval((set_variables + tokens).join(" "))
      }
    end

    class << self
      private

      def convert_type_if_needed(value)
        if value.is_a?(Numeric)
          " = #{value};"
        else
          " = '#{value}';"
        end
      end

      def available_keys(table)
        table.map { |key, value| key }
      end
    end
  end
end
