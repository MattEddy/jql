module JsonQL
  class Tolkienizer
    # the lord of the things

    TOKEN_LOOKUP = {
      "=" => "==",
      "OR" => "||",
      "AND" => "&&"
    }

    def self.run(query)
      query.split(/\s(?=(?:[^']|'[^']*')*$)/).map do |token|
        if TOKEN_LOOKUP[token.upcase]
          TOKEN_LOOKUP[token.upcase]
        else
          token
        end
      end
    end
  end
end
