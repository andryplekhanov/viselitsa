if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require 'unicode_utils'

require_relative "lib/game.rb"
require_relative "lib/result_printer.rb"
require_relative "lib/word_reader.rb"

current_path = File.dirname(__FILE__)

printer = ResultPrinter.new

reader = WordReader.new

slovo = reader.read_from_file(current_path + "/data/words.txt")

game = Game.new(slovo)

while game.status == 0 do
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)
puts "Было загадано слово: #{slovo}"