require 'colorize'
require "./piece.rb"
require './board.rb'

def Game
  
  def initialize
    @board = Board.new
    @board.setup(0, 2, :b)
    @board.setup(5, 7, :w)
  end
  
  