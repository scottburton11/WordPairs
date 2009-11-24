module WordPairs
  module ReverseAlternate
    
    attr_accessor :trim
    
    def alternate
      return nil unless has_alternate?  # if trim > length || reverse_tail_indistinct? #
      @alternate ||= "#{head}#{tail_reversed}"
    end

    def has_alternate?
      trim <= length && !reverse_tail_indistinct?
    end

    def trim    
      @trim ||= length
    end

    private

    def head
      self[-(length),(length-trim)]
    end

    def tail
      @tail ||= self[-(trim), trim]
    end

    def tail_reversed
      @tail_reversed ||= tail.reverse
    end

    def reverse_tail_indistinct?
      tail == tail_reversed
    end
  end
end