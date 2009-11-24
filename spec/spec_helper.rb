require 'rubygems'
require 'spec/autorun'

require File.dirname(__FILE__) + "/../lib/word_pairs.rb"
Dir.glob(File.dirname(__FILE__) + "/support/**/*.rb").each { |support_library| require support_library }