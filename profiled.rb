require 'lib/word_pairs'
require "strscan"

def findem(string)
  substring = Substring.new(string, 2)

  # matches = []

  matches = WORDS.select {|w| w[substring.matcher] }

  matches.each do |word|
    matches << word if word[substring.matcher] && word == substring + substring.tail.reverse
  end

  matches.join(", ")
end

def findem2(string)
  substring = Substring.new(string, 2)
  matches = BIGSTRING.scan(/^#{substring}\w{2}\b/).select{|w| (w == (substring + substring.tail.reverse)) && (w != substring.full)}
  puts matches.unshift(substring.full).join(", ") if matches.size > 1
end


# test_words = []
# size = WORDS.size
# 10.times do
#   test_words << WORDS[rand(size)]
# end
# 
# test_words.uniq!
# 
# test_words.each do |word|
#   # puts findem(word)
#   puts findem2(word)
# end

# WORDS.each do |word|
#   findem2(word)
# end

WORDS[10000..15000].each do |word|
  begin
    substring = Substring.new(word, 2)
    result = SubstringMatcher.find_alternates(substring, DICTIONARY)
    puts result if result
  rescue ArgumentError #word too short, output nothing
  rescue Exception => e
    puts "There was an error with #{word}, the exception raised was: #{e}"
    break
  end
end


# @scanner = StringScanner.new(DICTIONARY)
# 
# WORDS[10000..15000].each do |word|
#   begin
#     substring = Substring.new(word, 2)
#     start_pos = @scanner.skip_until(/\b#{substring.full}\b/)
#     scan = @scanner.scan_until(substring.alternate_matcher)
#     result = SubstringMatcher.find_alternates(substring, scan) unless scan.nil?
#     puts result if result
#     @scanner.pos = start_pos
#   rescue ArgumentError #word too short, output nothing
#   # rescue Exception => e
#   #   puts "There was an error with #{word}, the exception raised was: #{e}"
#   #   break
#   end
# end