module JsonQL
  class Parser
    def self.run(query)
      new(query)
    end

    def initialize(query)
      @tokens = Tolkienizer.run(query)
    end

    def column_select
      Proc.new { |table|
        selected_columns.call(table).map do |column|
          {
            column => table.map { |row| row[column] }
          }
        end.flatten
      }
    end

    def table_select
      Proc.new { |json_object|
        json_object[tokens.slice(from_index + 1)]
      }
    end

    def where_index
      tokens.index('WHERE')
    end

    def filter_conditions_from_tokens
      Condition.create_from_tokens(condition_tokens)
    end

    private

    def selected_columns
      Proc.new { |table|
        if column_tokens == ["*"]
          table.first.map { |key, value| key }
        else
          column_tokens
        end
      }
    end

    def condition_tokens
      tokens.slice(where_index + 1, tokens.length)
    end

    def column_tokens
      tokens.slice(select_index + 1, from_index - 1)
    end

    def select_index
      tokens.index('SELECT')
    end

    def from_index
      tokens.index('FROM')
    end

    attr_reader :tokens
  end
end
