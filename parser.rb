require_relative 'scanner'

# Parser class to build AST
class Parser

  TERMINALS = ['>', '<', '+', '-', ',', '.']

  def initialize(code='')
    @scanner = Scanner.new code
  end

  def build_tree
    tree = new ASTNode
    tok = @scanner.next_token

    case tok
    when nil
      return nil
    when '['
      
    end

    tree
  end
end