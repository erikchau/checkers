class Piece
  SLIDES = [[-1, 1], [-1, -1]]
  JUMPS = [[-2, 2], [-2, -2]]  
  
  attr_accessor :color
  
  def initialize(color, position, board)
    @color = color
    @pos = position
    @board = board
    @symbol = {b: "x", w: "o"}
    @king = false
  end
  
  def symbol
    @symbol[@color]
  end
  
  def slide_dirs
    SLIDES.map{ |dir| dir.map {|i| i * (@color == :w ? 1 : -1)}}
  end
  
  def dirs
    slide_dirs
  end
  
  def moves
    possible_moves = []
    dirs.each do |dir|
      new_x, new_y = (@pos[0] + dir[0]), (@pos[1] + dir[1])
      if @board[new_x, new_y].nil? 
        possible_moves << [new_x, new_y] if @board.on_board?(new_x, new_y)
      else
        if @board.capturable?(pos,[new_x, new_y])
          capx, capy = (@pos[0] + (dir[0] * 2)), (@pos[1] + (dir[1] * 2))
          possible_moves << [capx, capy] if @board.on_board?(capx, capy)
        end
      end
    end
    possible_moves
  end
    
  
  def perform_slide(to_pos)
    if moves.include?(to_pos)
      @board[@pos[0], @pos[1]] = nil
      @pos = to_pos
      @board[to_pos[0], to_pos[1]] = self
    end
  end
  

    
    
  end
  
  def maybe_promote
  end
  
end


