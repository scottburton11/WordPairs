require File.dirname(__FILE__) + "/../../spec_helper.rb"

describe SubstringMatcher do
  describe "with phoney baloney words" do
    before(:each) do
      @words = ["foo", "fooa", "foob", "fooba", "foobar", "foobra", "foobart"]
      @substring = Substring.new("foobar", 2)
    end

    it "matches predecessors" do
      SubstringMatcher.predecessors(@substring, @words).should eql(['foo', 'fooa'])
    end

    it "matches successors" do
      SubstringMatcher.successors(@substring, @words).should eql(['fooba', "foobar", "foobra", "foobart"])
    end

    it "matches substrings" do
      SubstringMatcher.matches(@substring, @words).should eql(['foobar', 'foobra'])
    end

  end
  
  describe "searching for alternates" do
    before(:each) do
      @dictionary = "burglar\r\nburglaries\r\nburglarious\r\nburglariously\r\nburglarise\r\nburglarize\r\nburglarized\r\nburglarizes\r\nburglarizing\r\nburglarproof\r\nburglars\r\nburglary\r\nburgle\r\nburgled\r\nburgles\r\nburgling\r\nburgomaster"
    end
    
    it "matches 'burglarise'" do
      SubstringMatcher.find_alternates(Substring.new("burglaries", 2), @dictionary).should eql("burglaries, burglarise")
    end
    
    it "returns nil if there is no matching alternate" do
      SubstringMatcher.find_alternates(Substring.new("foobart", 2), @dictionary).should be_nil
    end
  end

end

