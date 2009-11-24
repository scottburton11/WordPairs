$LOAD_PATH << File.dirname(__FILE__) + "/../lib"

require 'word_pairs/reverse_alternate'
require 'core/string'

module WordPairs
  
  Dictionary = File.read(File.dirname(__FILE__) + "/../wordsEn.txt")
  Words = Dictionary.scan(/\b\w+\b/)
  
  def self.run(words = WordPairs::Words, dictionary = WordPairs::Dictionary, trim = 2)
    words.each do |word|
      begin
        word.trim = trim
        result = ReverseAlternateFinder.find(word.alternate, dictionary) if word.has_alternate?
        puts "#{word}, #{result[0]}" unless result.nil?
      rescue Exception => e
        puts "There was an error with #{word}, the exception raised was: #{e}"
        break
      end
    end
  end
  
  class ReverseAlternateFinder  
    def self.find(alternate, dictionary)
      dictionary.match(/\b#{alternate}\b/) 
    end
  end
  
end
