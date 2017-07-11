require_relative 'scanner'

# Parser class to build AST
class Parser
  # statement_list -> statement | statement statement_list
  # statement -> L_BRACKET statement_list R_BRACKET
  #              | LESS_THAN | GREATER_THAN | PLUS | MINUS | DOT | COMMA

  def initialize(code = '')
    @scanner = Scanner.new code
    @curr_token = nil
  end

  def statement_list
    BlockNode.new.tap do |root|
      @curr_token = @scanner.next_token
      while !@curr_token.nil? && operation?(@curr_token.value)
        root.list << statement
        @curr_token = @scanner.next_token
      end
    end
  end

  def statement
    case @curr_token.type
    # when :l_brace
    #   block
    when :less_than, :greater_than, :plus, :minus, :dot, :comma
      OpNode.new @curr_token.value
    when :l_bracket
      statement_list
    # when :int
    #   IntNode.new @curr_token.value
    # when :sym
    #   SymNode.new @curr_token.value
    end
  end

  def parse
    statement_list
  end

  private

  # gross, fix me
  def operation?(type)
    '<>+-.,'.include? type
  end
end
