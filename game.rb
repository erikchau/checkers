require 'colorize'
require "./piece.rb"
require './board.rb'
require './errors.rb'

class Game
  
  def initialize(player1, player2)
    @board = Board.new
    @board.setup(0, 2, :b)
    @board.setup(5, 7, :w)
    @player1 = Player.new(player1, :w)
    @player2 = Player.new(player2, :b)
  end
  
  def play
    @board.render
    until @board.piece_count(:b) == 0 || @board.piece_count(:w) == 0 
      puts "Please enter your move sequence beginning with your starting piece"
      puts "ex: 00 11 22 33 44 55"
      seq = @player.get_seq
      @board.parse(seq)
    end
  end
  
end



a = Board.new
a.setup(0,2,:b)
a.setup(5,7,:w)
a[7,7] = Piece.new(:b, [7,7], a)
a[7,7].king = true
a[5,5] = nil
a[7,3] = nil
a[7,7].perform_moves([[5,5]])
a.render

# a[5,5].perform_moves([[4,4]])
# a[4,4].perform_moves([[3,3]])
# a[6,6].perform_moves([[5,5]])
# a.render
# a[2,2].perform_moves([[4,4],[6,6]])
# a.render
