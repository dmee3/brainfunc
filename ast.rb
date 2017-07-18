# Abstract Syntax Tree structure
class ASTNode
  def to_s(indent = '')
    "#{indent}<#{self.class}>"
  end
end

# Operation node
class OpNode < ASTNode
  attr_accessor :op
  def initialize(op = '')
    @op = op
  end

  def to_s(indent = '')
    "#{indent}<#{self.class}: #{@op}>"
  end
end

# Block node
class BlockNode < ASTNode
  attr_accessor :list
  def initialize(statements = [])
    @list = statements
  end

  def to_s(indent = '')
    "#{indent}<#{self.class}>\n".tap do |s|
      @list.each { |n| s << n.to_s(indent + '  ') << "\n" }
    end
  end
end

# Loop node
class LoopNode < ASTNode
  attr_accessor :list
  def initialize(statements = [])
    @list = statements
  end

  def to_s(indent = '')
    "#{indent}<#{self.class}>\n".tap do |s|
      @list.each { |n| s << n.to_s(indent + '  ') << "\n" }
    end
  end
end

# Integer node
class IntNode < ASTNode
  attr_accessor :value

  def initialize(val = '')
    @value = val
  end

  def to_s(indent = '')
    "#{indent}<#{self.class}: #{@value}>"
  end
end
