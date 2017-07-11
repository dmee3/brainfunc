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
