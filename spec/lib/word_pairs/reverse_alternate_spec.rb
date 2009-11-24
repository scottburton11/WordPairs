require File.dirname(__FILE__) + "/../../spec_helper.rb"

class String
  include WordPairs::ReverseAlternate
end


describe String, "with ReverseAlternate mixed in" do
  describe "and a distinct ending" do
    before(:each) do
      @string = String.new("briskest")
      @string.trim = 2
    end

    it "has an alternate" do
      @string.should respond_to(:alternate)
    end

    it "has a head substring" do
      @string.send(:head).should eql("briske")
    end

    it "has a tail substring" do
      @string.send(:tail).should eql("st")
    end

    describe "alternate" do

      it "reverses the last letters" do
        @string.alternate.should eql("briskets")
      end

    end  
  end
  
  describe "with an indistinct ending" do
    before(:each) do
      @string = String.new("dutchess")
      @string.trim = 2
    end
    
    it "has no alternate" do
      @string.alternate.should be_nil
    end
  end
  
  describe "with a word length shorter than the trim length" do
    before(:each) do
      @string = String.new("castro")
      @string.trim = 7
    end
    
    it "has no alternate" do
      @string.alternate.should be_nil
    end
  end
  
  describe "with no trim length provided" do
    before(:each) do
      @string = String.new("censure")
    end
    
    it "reverses the entire word" do
      @string.alternate.should eql("erusnec")
    end
  end
  
end