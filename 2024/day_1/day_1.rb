@array_1 = []
@array_2 = []

File.foreach('day_1_input.txt') do |line|
  left, right = line.split.map(&:to_i)
  @array_1 << left
  @array_2 << right
end

def challenge_1
  sorted_array_1 = @array_1.sort
  sorted_array_2 = @array_2.sort
  distance = 0

  sorted_array_1.each_with_index do |value, index|
    distance += (value - sorted_array_2[index]).abs
  end

  distance
end

p challenge_1

def challenge_2
  similarity_score = 0
  @array_1.each_with_index do |value, index|
    size = @array_2.filter { |v| v == value }.size
    similarity_score += size*value
  end

  similarity_score
end

p challenge_2