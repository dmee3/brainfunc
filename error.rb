# Unknown token found
class InvalidTokenError < StandardError
  attr_accessor :message

  def initialize(tok)
    @message = "Invalid token: #{tok}"
  end
end

# Loop imbalanced
class LoopMismatchError < StandardError
  attr_accessor :message

  def initialize
    @message = 'Mismatched loop construct [...]'
  end
end
