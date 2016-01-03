require_relative 'lib/piece'
require_relative 'lib/bishop'
require_relative 'lib/board'
require_relative 'lib/game'
require_relative 'lib/king'
require_relative 'lib/knight'
require_relative 'lib/pawn'
require_relative 'lib/queen'
require_relative 'lib/rook'
require 'yaml'
include Chess

SAVE_FILE = "saved_game.sav"

def display_main_menu
  puts "1. New game"
  puts "2. Load last saved state"
  input = gets.chomp
  return nil unless ["1", "2"].include?(input)
  input
end

def new_game
  game = Game.new(Board.new)
  play_game(game)
end

def load_game
  game = YAML::load(File.open(SAVE_FILE, "r") { |f| f.read })
  play_game(game)
end

def save_game(game)
  File.open(SAVE_FILE, "w") { |f| f.write YAML::dump(game) }
end

def play_game(game)
  while true
    game.board.show_board
    begin
      puts "#{game.current_player.capitalize} player's move."
      puts "Type 'save' to save game"
      print "Enter your move: "
      input = gets.chomp
      if input.upcase == "SAVE"
        save_game(game)
        redo
      else
        from, to = input.upcase.split
        game.move(from, to)
      end
    rescue => e
      puts e.message
      puts "Invalid move! Try again."
      redo
    end
  end
end

# executable code

puts "Welcome to Ruby Chess!"
  
input = nil
until input
  case input = display_main_menu
  when "1" then new_game
  when "2" then load_game
  else
    puts ""
    puts "Invalid choice, try again."
    puts ""
  end
end

