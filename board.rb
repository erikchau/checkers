class Board

  def initialize
    @board = Array.new(8){ Array.new(8)}
  end

  def render
    @board.each_with_index do |row, row_ind|
      row.each_with_index do |tile, col_ind|
        if tile == nil
          if (row_ind + col_ind) % 2 == 0
            print "   ".colorize(:background => :light_black)
          else
            print "   ".colorize(:background => :white)
          end
        else
          if (row_ind + col_ind) % 2 == 0
            print " #{self[row_ind, col_ind].symbol} ".colorize(:background => :light_black)
          else
            print " #{self[row_ind, col_ind].symbol} ".colorize(:background => :white)
          end
        end
      end
      puts "\n"
    end
    puts
  end

  def [](row, col)
    @board[row][col]
  end

  def []=(row, col, piece)
    @board[row][col] = piece
  end

  def setup(start_row, end_row, color)
    start_row.upto(end_row) do |row|
      0.upto(7) do |col|
        if (row + col) % 2 == 0
          @board[row][col] = Piece.new(color, [row, col], self)
        end
      end
    end
  end
  
  def on_board?(row, col)
    row.between?(0,7) && col.between?(0,7)
  end
  
  def capturable?(pos, cap_pos)
    self[pos[0], pos[1]].color != self[cap_pos[0], cap_pos[1]].color 
  end
  
  def deep_dup
    dup_board = Board.new
    @board.each_with_index do |row, row_ind|
      row.each_with_index do |piece, col_ind|
        next if piece.nil?
        dup_board[row_ind, col_ind] = 
             Piece.new(piece.color, [row_ind, col_ind], dup_board)
      end
    end
    dup_board
  end
  
  def piece_collect(color)
    @board.flatten.compact.select { |piece| piece.color == color}
  end
  
  def piece_count(color)
    piece_collect(color).count
  end
  
  def parse(seq)
  end
    
    
end


