# Brainfunc Interpreter
class Interpreter
  SIZE = 30_000

  # Initializer takes in program and input
  def initialize(code = '', input = '')
    Preprocessor.check code
    Preprocessor.sanitize! code
    @parser = Parser.new code
    @tape = Array.new SIZE, 0
    @cell = 0
  end

  def run
    tree = @parser.parse
    print tree.to_s
  end

  private

  def visit_block(node)
    node.list.each { |n| visit_op n }
  end

  def visit_loop(node)
    cond_cell = @cell
    node.list.each { |n| visit_op n } while @tape[cond_cell] != 0
  end

  def visit_op(node)
    case node.op
    when '<'
      @cell -= 1 if @cell > 0
    when '>'
      @cell += 1 if @cell < SIZE - 1
    when '+'
      @tape[@cell] += 1
    when '-'
      @tape[@cell] -= 1
    when '.'
      print @tape[@cell]
    when ','
      @tape[@cell] = STDIN.getc
    end
  end
end
