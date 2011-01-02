module Codebreaker
  class Stats
    attr_reader :codes
    
    def initialize
      @codes = []
      @counts = (1..4).collect { Hash.new { |h, k| h[k] = 0 } }
    end
    
    def puts(code)
      if code =~ /^\w \w \w \w$/
        codes << code.split
        code.split.each_with_index do |color, index|
          @counts[index][color] += 1
        end
      end
    end
    
    def count_for(color, position)
      @counts[position-1][color]
    end
  end
end