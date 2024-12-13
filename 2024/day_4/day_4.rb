require 'matrix'

@word = 'XMAS'
@matches = 0
@x_mas_matches = 0

def matrix
  arrays = []
  File.foreach('2024/day_4/day_4_input.txt') do |line|
    arrays << line.chomp.chars
  end
  Matrix[*arrays]
end

def find_word_in_rows
  matrix.row_vectors.each_with_index do |row, index|
    row_str = row.to_a.join
    row_str.scan(/#{@word}/) do |match|
      @matches += 1
    end
    row_str.reverse.scan(/#{@word}/) do |match|
      @matches += 1
    end
  end
end

def find_word_in_columns
  matrix.column_vectors.each_with_index do |column, index|
    column_str = column.to_a.join
    column_str.scan(/#{@word}/) do |match|
      @matches += 1
    end
    column_str.reverse.scan(/#{@word}/) do |match|
      @matches += 1
    end
  end
end

def diagonals_from_matrix
  diagonals = []

  row_count = matrix.row_count
  col_count = matrix.column_count

  # Top-left to bottom-right diagonals
  (0...row_count).each do |i|
    diagonals << (0...[row_count - i, col_count].min).map { |j| matrix[i + j, j] }
  end

  (1...col_count).each do |i|
    diagonals << (0...[row_count, col_count - i].min).map { |j| matrix[j, i + j] }
  end

  # Top-right to bottom-left diagonals
  (0...row_count).each do |i|
    diagonals << (0...[row_count - i, col_count].min).map { |j| matrix[i + j, col_count - 1 - j] }
  end

  (1...col_count).each do |i|
    diagonals << (0...[row_count, col_count - i].min).map { |j| matrix[j, col_count - 1 - i - j] }
  end

  diagonals
end

def find_word_in_diagonals
  diagonals_from_matrix.each do |diagonal|
    diagonal_str = diagonal.join
    @matches += diagonal_str.scan(/#{@word}/).count
    @matches += diagonal_str.reverse.scan(/#{@word}/).count
  end
end

def challenge_1
  find_word_in_rows
  find_word_in_columns
  find_word_in_diagonals
  @matches 
end

p challenge_1

def matches_x_mas?(row_index, col_index)
  row_count = matrix.row_count
  col_count = matrix.column_count

  # Check bounds and construct diagonals safely
  diagonal_1 = [
    (matrix[row_index - 1, col_index - 1] if row_index - 1 >= 0 && col_index - 1 >= 0),
    matrix[row_index, col_index],
    (matrix[row_index + 1, col_index + 1] if row_index + 1 < row_count && col_index + 1 < col_count)
  ].compact.join

  diagonal_2 = [
    (matrix[row_index - 1, col_index + 1] if row_index - 1 >= 0 && col_index + 1 < col_count),
    matrix[row_index, col_index],
    (matrix[row_index + 1, col_index - 1] if row_index + 1 < row_count && col_index - 1 >= 0)
  ].compact.join

  diagonal_1_matches = diagonal_1 == 'MAS' || diagonal_1 == 'SAM'
  diagonal_2_matches = diagonal_2 == 'MAS' || diagonal_2 == 'SAM'

  diagonal_1_matches && diagonal_2_matches
end

def challenge_2
  matrix.row_vectors.each_with_index do |row, row_index|
    row.each_with_index do |char, col_index|
      if char == "A"
        @x_mas_matches += 1 if matches_x_mas?(row_index, col_index)
      end
    end  
  end
  @x_mas_matches
end

p challenge_2
