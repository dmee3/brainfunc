# Scanner class to break code into tokens
class Scanner
  def initialize(code = '')
    @code = code
  end

  def next_token
    if @code.empty?
      nil
    elsif digit? @code[0]
      integer_token
    elsif alpha? @code[0]
      symbol_token
    else
      generic_token
    end
  end

  def integer_token
    val = @code.slice!(/^\d+/)
    if val.empty?
      nil
    else
      Token.new TOKEN_TYPES['INT'], val
    end
  end

  def symbol_token
    val = @code.slice!(/^[_a-zA-Z]+/)
    if val.empty?
      nil
    else
      Token.new TOKEN_TYPES['SYM'], val
    end
  end

  def generic_token
    val = @code.slice! 0
    raise InvalidTokenError.new(val) unless TOKEN_TYPES.key? val
    Token.new TOKEN_TYPES[val], val
  end

  private

  def digit?(c)
    c =~ /\d/
  end

  def alpha?(c)
    c =~ /[_a-zA-Z]/
  end
end
