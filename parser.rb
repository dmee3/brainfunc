# Parser class to build AST
class Parser
  # statement_list -> statement | statement statement_list
  # statement -> L_BRACKET statement_list R_BRACKET
  #              | LESS_THAN | GREATER_THAN | PLUS | MINUS | DOT | COMMA | INT

  def initialize(code = '')
    @scanner = Scanner.new code
    @curr_token = nil
  end

  def statement
    case @curr_token.type
    when :less_than, :greater_than, :plus, :minus, :dot, :comma
      OpNode.new @curr_token.value
    when :l_bracket
      statement_list
    when :int
      IntNode.new @curr_token.value
    else
      raise InvalidTokenError.new(@curr_token.value)
    end
  end

  def statement_list
    root = LoopNode.new
    @curr_token = @scanner.next_token
    while !@curr_token.nil? && @curr_token.type != :r_bracket
      root.list << statement
      @curr_token = @scanner.next_token
    end

    raise LoopMismatchError if @curr_token.nil?

    @curr_token = @scanner.next_token
    root
  end

  def parse
    BlockNode.new.tap do |root|
      @curr_token = @scanner.next_token
      until @curr_token.nil?
        root.list << statement
        @curr_token = @scanner.next_token
      end
    end
  end
end
