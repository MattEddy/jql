module JsonQL
  class Parser
    def initialize(query)
      @tokens = Tolkienizer.run(query)
      raise ParseError unless starts_with_select? && contains_a_from?
    end

    def starts_with_select?
      tokens.first == 'select'
    end

    def contains_a_from?
      tokens.include?('from')
    end

    def columns
      tokens.slice(1, from_index - 1)
    end

    def conditions
      if tokens.include?('where')
        @conditions ||= Condition.create_from_tokens(condition_tokens)
      end
    end

    def table_name
      tokens.slice(from_index + 1, from_index + 2).first
    end

    def selected_condition
      conditions[condition_column]
    end

    def condition_column
      condition_tokens.first
    end

    private

    def condition_tokens
      tokens.slice(tokens.index('where') + 1, tokens.length)
    end

    def from_index
      tokens.index('from')
    end

    attr_reader :tokens
  end
end
