module JsonQL
  class Executor
    require 'json'

    def initialize(file:)
      @dataset = JSON.parse(file)
    end

    def execute(query)
      @parser = Parser.new(query)

      columns.map do |column|
        {
          column_name: column,
          data:        get_data_from_table(column).compact
        }
      end
    end

    private

    def columns
      if parser.columns == ["*"]
        all_columns
      else
        parser.columns
      end
    end

    def all_columns
      dataset[parser.table_name][0].map do |key, value|
        key
      end
    end

    def get_data_from_table(column)
      dataset[parser.table_name].map do |row|
        if has_condition?(column)
          row[column] if call_condition(row[parser.condition_column])
        else
          row[column]
        end
      end
    end

    def call_condition(datum)
      parser.selected_condition.call(datum)
    end

    def has_condition?(column)
      parser.conditions && parser.selected_condition
    end

    attr_reader :dataset, :parser
  end
end
