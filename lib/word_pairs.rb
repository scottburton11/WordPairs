# WORDS = IO.readlines(File.dirname(__FILE__) + "/../wordsEn.txt")
# WORDS = IO.read(File.dirname(__FILE__) + "/../wordsEn.txt").split("\n").collect{|line|line.chomp}
DICTIONARY = File.read(File.dirname(__FILE__) + "/../wordsEn.txt")
WORDS = DICTIONARY.split("\r\n").map!{|word| word.chomp }

# Dir.glob(File.dirname(__FILE__) + "/*.rb").each {|file| require file }

$LOAD_PATH << File.dirname(__FILE__) + "/../lib"

require 'word_pairs/substring'
require 'word_pairs/substring_matcher'