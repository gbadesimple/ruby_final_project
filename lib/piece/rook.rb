require_relative 'piece'

class Rook < Piece
  def try_path(a, b, direction)
    start = square(a[0], a[1])
    queue = [start]
    path = []
    loop do
      current_square = queue.shift
      # found: add it to the path and exit loop
      if current_square.x == b[0] && current_square.y == b[1]
        path << current_square
        break
      end
      # not found: add children to the queue
      return nil if current_square.generate_child(direction).nil? # done with this direction
      queue << current_square.generate_child(direction)
    end
    # go through parents of each square starting at the end position and add them to the path in reverse order
    current = path[0].parent
    until current.nil?
      path.unshift(current)
      current = current.parent
    end
    return convert_path(path)
  end

  def directions
    [up, right, down, left]
  end
end