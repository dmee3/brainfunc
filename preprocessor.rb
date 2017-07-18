# Pre-processor for Brainfunc programs
module Preprocessor
  def self.sanitize!(code)
    code.gsub!(/#.*$/, '')
    code.gsub!(/\s/, '')
  end

  def self.check(code)
    depth = 0
    code.each_char do |c|
      # Record changing loop depth
      if c == '['
        depth += 1
      elsif c == ']'
        depth -= 1
      end

      raise LoopMismatchError if depth < 0
    end

    raise LoopMismatchError if depth != 0
  end
end
