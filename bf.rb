require_relative 'ast'
require_relative 'error'
require_relative 'interpreter'
require_relative 'parser'
require_relative 'preprocessor'
require_relative 'scanner'
require_relative 'token'

if ARGV[0]

  puts "\n"
  code = File.read(ARGV[0])

  begin
    # Check code
    Preprocessor.check code
    Preprocessor.sanitize! code

    # Create interpreter
    if ARGV[1]
      input = File.read(ARGV[1])
      b = Interpreter.new(code, input)
    else
      b = Interpreter.new(code)
    end

    # Run interpreter
    b.run
  rescue StandardError => e
    puts e.message
  end

else
  puts 'Invalid arguments'
  puts 'Usage: ruby bf.rb <code-file> <input-file>'
end

puts "\n"
