# Holds a representation of a single token
class Token
  attr_accessor :type, :value

  def initialize(type, value = '')
    @type = type
    @value = value
  end

  def to_s
    "<#{@type}:#{@value}>"
  end
end

TOKEN_TYPES = {
  'INT' => :int,
  'SYM' => :sym,
  '{' => :l_brace,
  '}' => :r_brace,
  '<' => :less_than,
  '>' => :greater_than,
  '+' => :plus,
  '-' => :minus,
  '[' => :l_bracket,
  ']' => :r_bracket,
  '.' => :dot,
  ',' => :comma
}.freeze
