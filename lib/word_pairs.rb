$LOAD_PATH << File.dirname(__FILE__) + "/../lib"

require 'word_pairs/reverse_alternate'
require 'core/string'

# = WordPairs
# WordPairs outputs pairs of words with alternate spellings. This example produces
# word alternates by reversing a variable-length ending word segment.
# 
# ex: agonies, agonise, analog, angola, animal, lamina
# 
# WordPairs outputs comma-separated pairs to STDOUT.
# 
# == Usage
# 
#   WordPairs.run(word_list, dictionary, trim_length)
#
# == Credits
#
#   Author:     Scott Burton <scott@burtonsound.com>
#   Copyright:  Copyright 2009, Burton Sound LLC
#   License:    Distributed under the MIT license, 
#               http://www.opensource.org/licenses/mit-license.php

module WordPairs
  
  Dictionary = File.read(File.dirname(__FILE__) + "/../wordsEn.txt")
  Words = Dictionary.scan(/\b[\w'-\.]+\b/)

  # Run the matcher, outputting word pairs to stdout.
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
    
    #Find a word in the provided dictionary. Produces an instance of MatchObject.
    def self.find(word, dictionary)
      dictionary.match(/\b#{word}\b/) 
    end
    
  end
  
end
