require_relative 'preprocessor'
require_relative 'brain'

if ARGV[0]

  code = File.read(ARGV[0])

  Preprocessor.check code
  Preprocessor.sanitize! code

  if ARGV[1]
    input = File.read(ARGV[1])
    b = Brain.new(code, input)
  else
    b = Brain.new(code)
  end

  # Run interpreter
  puts "\n"
  b.interpret
  puts "\n\n"

else
  puts "\nError: invalid arguments."
  puts "Usage: ruby bf.rb <code-file> <input-file>\n\n"
end
