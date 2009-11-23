class SubstringMatcher
  
  def self.predecessors(string, words)
    word_matches = []
    words.each {|word| word_matches << word if word < string}
    return word_matches
  end
  
  def self.successors(string, words)
    word_matches = []
    words.each {|word| word_matches << word if word > string}
    return word_matches
  end
  
  def self.matches(substring, words)
    word_matches = []
    words.each {|word| word_matches << word if word.length == substring.full.length && Substring.new(word,2) == substring  }
    return word_matches
  end
  
  def self.find_alternates(substring, dictionary)
    word_matches = dictionary.scan(substring.alternate_matcher) if substring.alternate
    unless word_matches.nil? || word_matches.empty?
      word_matches.unshift(substring.full).join(", ")
    else
      nil
    end
  end
  
end