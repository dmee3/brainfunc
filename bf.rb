require_relative 'interpreter'

if ARGV[0]

  code = File.read(ARGV[0])

  Preprocessor.check code
  Preprocessor.sanitize! code

  if ARGV[1]
    input = File.read(ARGV[1])
    b = Interpreter.new(code, input)
  else
    b = Interpreter.new(code)
  end

  # Run interpreter
  puts "\n"
  b.run
  puts "\n\n"

else
  puts "\nError: invalid arguments."
  puts "Usage: ruby bf.rb <code-file> <input-file>\n\n"
end
