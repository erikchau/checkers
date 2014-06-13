class Piece
  SLIDES = [[-1, 1], [-1, -1]]
  KING_SLIDES = [[-1, 1], [-1, -1], [1, -1], [1, 1]]
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
  
  def dirs
    if @king
      KING_SLIDES
    else
      SLIDES.map{ |dir| dir.map {|i| i * (@color == :w ? 1 : -1) } }
    end
  end
  
  def calc_new_pos(dir, capt = false)
    i = (capt ? 2 : 1)
    new_x, new_y = (@pos[0] + (dir[0] * i)), (@pos[1] + (dir[1] * i))
    new_pos = [new_x, new_y]
    new_pos
  end
  
  def slide_moves
    moves = []
    dirs.each do |dir|
      new_pos = calc_new_pos(dir)
      if @board[new_pos[0], new_pos[1]].nil? 
        moves << new_pos if @board.on_board?(new_pos[0], new_pos[1])
      end
    end
    moves
  end
  
  def jump_moves
    moves = []
    dirs.each do |dir|
      new_pos = calc_new_pos(dir)
      if !@board[*new_pos].nil? && @board.capturable?(@pos, new_pos)
        cap_pos = calc_new_pos(dir, capt = true)
        moves << cap_pos if @board.on_board?(cap_pos[0], cap_pos[1]) && 
          @board[cap_pos[0], cap_pos[1]].nil?
      end
    end
    moves
  end
  
  def perform_slide(to_pos)
    if slide_moves.include?(to_pos)
     perform_slide!(to_pos)
    end
    return
  end
  
  def perform_slide!(to_pos)
      @board[@pos[0], @pos[1]] = nil
      @pos = to_pos
      @board[to_pos[0], to_pos[1]] = self
      return
  end
  
  
  def perform_jump(to_pos)
    direction = (color == :w ? 1 : -1)
    if jump_moves.include?(to_pos)
      cap_pos = [(to_pos[0] + direction), (to_pos[1] + direction)]
      perform_slide!(cap_pos)
      perform_slide(to_pos)
    end
    return
  end
  
  def maybe_promote
    kingrow = {color == :w ? 0 : 7}
    king = true if 
  end
  
  
  def perform_moves!(move_sequence)
    if move_sequence.count == 1
      if slide_moves.include?(move_sequence[0])
        perform_slide(move_sequence[0])
      elsif jump_moves.include?(move_sequence[0])
        perform_jump(move_sequence[0])
      else 
        raise InvalidMoveError
      end
    else
      move_sequence.each do |move|
        if jump_moves.include?(move)
          perform_jump(move)
        else
          raise InvalidMoveError
        end
      end
    end
    true
  end
 
  def valid_move_seq?(move_sequence)
    dup_board = @board.dup
    dup_piece = dup_board[@pos[0], @pos[1]]
    raise InvalidMoveError unless dup_piece.perform_moves!(move_sequence)
    true
  end
  
  def perform_moves(move_sequence)
    if valid_move_seq?(move_sequence)
      perform_moves!(move_sequence)
    else
      raise InvalidMoveError
    end
  end
    
  
end


