class Substring < String
  
  attr_reader :full, :tail
  
  def initialize(string, trim_length)
    super(string) if string.nil?
    @full = string.strip
    raise ArgumentError, "The trim length is too long for that string" if trim_length > word_length
    @trim_length = trim_length
    super(@full.match(matcher)[1])
  end
  
  def tail
    @tail ||= @full.match(matcher)[2]
  end
  
  def word_length
    @length ||= @full.length
  end
  
  def matcher
    %r|^(#{@full[-(word_length),(word_length-@trim_length)]})([\w'-]{#{@trim_length}})$|
  end
  
  def alternate_matcher
    %r|\b#{alternate}\b|
  end
  
  def alternate
    self + tail.reverse unless indistinct_tail?
  end
  
  private
  
  def indistinct_tail?
    # return true if tail[0] == tail[1]
    return true if tail == tail.reverse
    false
  end
  
end