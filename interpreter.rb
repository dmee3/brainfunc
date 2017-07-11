# Brainfunc Interpreter
class Interpreter
  SIZE = 30_000

  # Initializer takes in program and input
  def initialize(code = '', input = '')
    @arr = Array.new(SIZE, 0)              # Byte array
    @prog = code.split('')                 # Program array
    @inp = input.split(' ').map!(&:ord)    # Input array
    @ap = 0                                # Byte array pointer
    @pp = 0                                # Program pointer
    @rc = false                            # Copy register
  end

  # Move left 1 cell
  def left
    abort('Error: tried to move below array bounds') if @ap <= 0
    @ap -= 1
  end

  # Move right 1 cell
  def right
    abort('Error: tried to move above array bounds') unless @ap < SIZE - 1
    @ap += 1
  end

  # Increment current cell
  def inc
    @arr[@ap] += 1
  end

  # Decrement current cell
  def dec
    @arr[@ap] -= 1
  end

  # Write from current cell to screen
  def put
    print @arr[@ap].chr
  end

  # Read into current cell from input array
  def get
    abort('Error: tried to read char at EOF') if @inp.empty?
    input = @inp.shift
    abort('Error: tried to read nil character') if input.nil?
    @arr[@ap] = input
  end

  # Either copy a cell's contents or paste from the copy register to
  # the current cell
  def copy_paste
    if @rc
      @arr[@ap] = @rc
      @rc = false
    else
      @rc = @arr[@ap]
    end
  end

  # Jump forward to matching closing bracket
  def forward
    cur_depth = 1
    while cur_depth > 0 && @pp < @prog.length - 1
      @pp += 1
      if @prog[@pp].chr == '['
        cur_depth += 1
      elsif @prog[@pp].chr == ']'
        cur_depth -= 1
      end
    end
  end

  # Jump back to matching opening bracket
  def back
    cur_depth = 1
    while cur_depth > 0 && @pp > 0
      @pp -= 1
      if @prog[@pp].chr == '['
        cur_depth -= 1
      elsif @prog[@pp].chr == ']'
        cur_depth += 1
      end
    end
  end

  # Read in a number to repeat the next command several times
  def repeat
    num = ''
    while @prog[@pp] =~ /[0-9]/
      num << @prog[@pp]
      @pp += 1
    end

    num.to_i.times { consume }
  end

  # Run through program code using pointer
  def interpret
    @pp = 0
    while @pp < @prog.length
      consume
      @pp += 1
    end
  end

  # Consume and respond to single token
  def consume
    if @prog[@pp] == '<'
      left
    elsif @prog[@pp] == '>'
      right
    elsif @prog[@pp] == '+'
      inc
    elsif @prog[@pp] == '-'
      dec
    elsif @prog[@pp] == '.'
      put
    elsif @prog[@pp] == ','
      get
    elsif @prog[@pp] == '*'
      copy_paste
    elsif @prog[@pp] == '['
      forward if @arr[@ap].zero?
    elsif @prog[@pp] == ']'
      back unless @arr[@ap].zero?
    elsif @prog[@pp] =~ /\d/
      repeat
    end
  end
end
