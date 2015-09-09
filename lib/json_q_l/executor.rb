module JsonQL
  class Executor
    def initialize(dataset:)
      @dataset = dataset
    end

    def execute(query)
      @parser = Parser.new(query)

      selected_columns
    end

    def selected_columns
      if filtered_table.empty?
        "Nothing matched query"
      else
        parser.column_select.call(filtered_table)
      end
    end

    def filtered_table
      if parser.where_index
        tables.map do |table|
          table if parser.filter_conditions_from_tokens.call(table)
        end.compact
      else
        tables
      end
    end

    def tables
      parser.table_select.call(dataset)
    end

    attr_reader :dataset, :parser
  end
end
