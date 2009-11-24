module WordPairs
  # ReverseAlternate provides an alternate spelling of a word
  # by reversing the tail segment. If a trim length is not 
  # provided, the entire word will be reversed.
  module ReverseAlternate
    
    # Alternate word spelling. Outputs nil if the trim length is too long
    # for the word, or if the reversed alternate word is equal to the original.
    def alternate
      return nil unless has_alternate?  # if trim > length || reverse_tail_indistinct? #
      @alternate ||= "#{head}#{tail_reversed}"
    end

    # Is the alternate distict? Is the trim length too long to produce an alternate?
    def has_alternate?
      trim <= length && !reverse_tail_indistinct?
    end

    # Trim length of the tail string segment. Default is the word length
    def trim    
      @trim ||= length
    end

    # Provide a positive integer trim length.
    def trim=(n)
      raise ArgumentError, "the trim length must be a positive integer" unless n.is_a?(Integer) && n > 0
      @trim = n
    end

    private

    # The head string segment
    def head
      self[-(length),(length-trim)]
    end

    # The tail string segment
    def tail
      @tail ||= self[-(trim), trim]
    end

    # The tail segment reversed
    def tail_reversed
      @tail_reversed ||= tail.reverse
    end

    # Is the tail segment distinct when reversed?
    def reverse_tail_indistinct?
      tail == tail_reversed
    end
  end
end