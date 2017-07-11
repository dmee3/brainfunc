# Scanner class to break code into tokens
class Scanner
  def initialize(code = '')
    @code = code
  end

  def next_token
    return nil if @code.empty?
    tok = @code.slice! 0
    tok << @code.slice!(/^\d+/) if tok =~ /\d/
  end
end
