require File.dirname(__FILE__) + "/../../spec_helper.rb"

describe Substring do
  before(:each) do
    @substring = Substring.new("foobar", 2)
  end
  
  it "is 'foob'" do
    @substring.should eql("foob")
  end
  
  it "#full retains the full string" do
    @substring.full.should eql("foobar")
  end
  
  it "#tail is the remainder" do
    @substring.tail.should eql("ar")
  end
  
  it "has a matcher" do
    @substring.should respond_to(:matcher)
  end
  
  it "has an alternate matcher" do
    @substring.should respond_to(:alternate_matcher)
  end

  it "contains substrings too" do
    @substring.should include("foo")
  end
  
  it "trims leading and trailing spaces from the provided string" do
    substring = Substring.new(" word ", 2)
    substring.should eql("wo")
    substring.alternate.should eql("wodr")
  end

  describe "validity" do
    
    it "raises ArgumentError if the trim length is greater than the word length" do
      lambda {Substring.new("a", 2)}.should raise_error(ArgumentError, "The trim length is too long for that string")
    end
    
    it "raises TypeError if the string is nil" do
      lambda {Substring.new(nil, 2)}.should raise_error(TypeError, "can't convert nil into String")
    end
    
  end
  
  describe "matcher" do
    
    it "is a regexp" do
      @substring.matcher.should be_an_instance_of(Regexp)
    end
    
    it "matches 'foob' from the beginning to the end of the provided string, plus two word characters, with the substring and tail selected" do
      @substring.matcher.should eql(/^(foob)([\w'-]{2})$/)
    end
    
    describe "matches" do
      
      before(:each) do
        @match_data = "foobar".match(@substring.matcher)
      end
      
      it "'foobar' first" do
        @match_data[0].should eql("foobar")
      end
      
      it "'foob' second" do
        @match_data[1].should eql("foob")
      end
      
      it "'ar' third" do
        @match_data[2].should eql("ar")
      end
      
    end
        
  end
  
  describe "alternate_matcher" do
    
    it "is a regexp" do
      @substring.alternate_matcher.should be_an_instance_of(Regexp)
    end
    
    it "matches 'foobra'" do
      @substring.alternate_matcher.should eql(/\bfoobra\b/)
    end
    
    describe "matches" do
      before(:each) do
        @dictionary = "foobra\r\nfoobar\r\noofoobar\r\nfoobaroo\r\nofoobra\r\noofoobaro\r\noofoobrao\r\n"
      end
      
      it "'foobra'" do
        @dictionary.scan(@substring.alternate_matcher).should eql(['foobra'])
      end
    end
    
  end

  describe "comparable" do
    
    it "should be equal to 'foob'" do
      @substring.should eql('foob')
    end
    
    it "should be less than 'fooba'" do
      @substring.should be < 'fooba'
    end
    
    it "should be greater than 'foo'" do
      @substring.should be > 'foo'
    end
    
  end
  
  describe "Words that match -2 substrings" do

    before(:each) do
      @words = ["foo", "foob", "fooba", "foobar", "foobart", "foobra"]
      @substring = Substring.new("foobar", 2)
    end
    
    it "should match 'foobar' and 'foobra'" do
      matches = []
      @words.each do |word|
        matches << word if word.match(@substring.matcher)
      end
    end
  end

  describe "reversed ending alternate" do
    
    it "should have the last two distinct letters reversed" do
      substring = Substring.new("foobar", 2)
      substring.alternate.should eql("foobra")
    end
    
    it "should be nil if the last segment's letters are indistinct" do
      substring = Substring.new("boss", 2)
      substring.alternate.should be_nil
    end
    
  end
end

describe Substring, "corner cases" do
  
  describe "like words with apostrophies" do
    it "works with the apostraphy in the substring segment" do
      substring = Substring.new("Lil'Wayne", 4)
      substring.should eql("Lil'W")
      substring.alternate.should eql("Lil'Wenya")
    end
    
    it "works with contractions" do
      substring = Substring.new("Donna's", 2)
      substring.should eql("Donna")
      substring.tail.should eql("'s")
      substring.alternate.should eql("Donnas'")
    end
  end
  
  describe "like words with hyphens" do
    it "works with the hyphen in the substring segment" do
      substring = Substring.new("Lil'Wayne-esque", 6)
      substring.should eql("Lil'Wayne")
      substring.tail.should eql("-esque")
      substring.alternate.should eql("Lil'Wayneeuqse-")
    end
  end
  
  describe "like words with abbreviations" do
    it "works without altering space" do
      substring = Substring.new("St. Tropez", 3)
      substring.should eql("St. Tro")
    end
  end
end