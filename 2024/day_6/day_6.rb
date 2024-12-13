require 'matrix'
require 'pry'

def matrix
  arrays = []
  File.foreach('2024/day_6/day_6_input.txt') do |line|
    arrays << line.chomp.chars
  end
  Matrix[*arrays]
end

def initial_coordinates
  matrix.row_vectors.each_with_index do |row, row_index|
    initial_position = row.to_a.index('^')
    return row_index,initial_position if initial_position
  end
  nil
end


def challenge_1
  hash_count = 0
  @visited_positions = [initial_coordinates.to_s]
  positions = 1
  row_index, column_index = initial_coordinates
  directions = { 'up' => [-1, 0], 'right' => [0, 1], 'down' => [1, 0], 'left' => [0, -1] }
  direction_keys = ['up', 'right', 'down', 'left']
  current_direction = 0

  loop do
    row_offset, col_offset = directions[direction_keys[current_direction]]
    next_row, next_col = row_index + row_offset, column_index + col_offset

    break if next_row < 0 || next_row >= matrix.row_count ||
             next_col < 0 || next_col >= matrix.column_count ||
             matrix[next_row, next_col] == ' '

    if matrix[next_row, next_col] == '#'
      current_direction = (current_direction + 1)
      current_direction = 0 if current_direction == 4
    else
      row_index, column_index = next_row, next_col

      position_string = [row_index, column_index].to_s
      unless @visited_positions.include?(position_string)
        @visited_positions << position_string
        positions += 1
      end
    end
  end
  
  positions
end

p challenge_1