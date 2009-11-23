require File.dirname(__FILE__) + "/spec_helper.rb"

describe "Background, in theory, " do
  describe "burglar" do
    before(:each) do
      @word = "burglar"
    end

    it "ends in 'ar'" do
      @word[-2,2].should eql("ar")
    end

    it "starts with 'burgl'" do
      @word[-7,5].should eql("burgl")
    end

    it "first segment can be determined using the length" do
      length = @word.length
      @word[-length,(length - 2)].should eql("burgl")
    end

  end

  describe "A word match" do
    before(:each) do
      @word1 = "burglar"
      @word2 = "burglra"
    end

    it "has an equal length" do
      @word1.length.should eql(@word2.length)
    end

    describe "determined by the first segment without the last two letters" do
      before(:each) do
        @length = @word1.length
        @regexp = %r|#{@word1[-@length,(@length-2)]}|
      end

      it "should match @word2" do
        @regexp.should match(@word2)
      end
    end
  end
  
end

describe "WORDS" do
  it "is an array of words" do
    WORDS.should be_an_instance_of(Array)
  end
end





