module JsonQL
  class Condition < Proc
    # a condition is a proc that can be run against some input data
    # evaluates to true or false
    # select * from users where name == matt

    def self.create_from_tokens(tokens)
      instance = new { |argument|
        eval(tokens.first + ' = argument;' + tokens.join(" "))
      }

      {
        tokens.first => instance
      }
    end
  end
end
