# Abstract Syntax Tree structure
class ASTNode
  attr_accessor :left, :right, :token

  def initialize(tok = nil)
    @left = nil
    @right = nil
    @token = tok
  end

  def is_terminal?
    @left == nil && @right == nil
  end
end