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
  clear_screen
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
  clear_screen
  until result = game.check_mate? do
    game.board.show_board
    begin
      puts "#{game.current_player.capitalize} player's move."
      puts "Type 'save' to save game, 'exit' to exit."
      print "Enter your move: "
      input = gets.chomp
      clear_screen
      if input.upcase == "SAVE"
        save_game(game)
        puts "Game saved"
        redo
      elsif input.upcase == "EXIT"
        exit
      else
        from, to = input.upcase.split
        game.move(from, to)
      end
    rescue
      puts "Invalid move! Try again."
      redo
    end
  end
  
  game.board.show_board
  case result
  when :white then puts "Black player wins!"
  when :black then puts "White player wins!"
  when :stalemate then puts "The game ended in a draw!"
  end
  
  puts ""
  puts "Press any key to exit"
  gets
  exit
  
end

def clear_screen
  Gem.win_platform? ? (system "cls") : (system "clear")
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

