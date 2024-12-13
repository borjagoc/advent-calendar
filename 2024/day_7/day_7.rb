require 'pry'

@equations = []
OPERATORS_1 = ['+', '*'].freeze
OPERATORS_2 = ['+', '*', '||'].freeze

File.foreach('2024/day_7/day_7_input.txt') do |line|
  @equations << line.chomp
end


def challenge_1
  total = 0
  @equations.each do |equation|
    equation_array = equation.split(' ')
    result = equation_array[0].gsub(':', '').to_i
    numbers = equation_array.slice(1, equation.size)
    permutations = OPERATORS_1.repeated_permutation(numbers.size).to_a
    permutations.each do |perm|
      accumulator = numbers.map(&:to_i).reduce(0) do |acc, number|
        acc.send(perm.shift, number)
      end
      if accumulator == result
        total += result
        break
      end
    end
  end
  total
end

p challenge_1

def challenge_2
  total = 0
  @equations.each do |equation|
    equation_array = equation.split(' ')
    result = equation_array[0].gsub(':', '').to_i
    numbers = equation_array.slice(1, equation.size)
    permutations = OPERATORS_2.repeated_permutation(numbers.size).to_a
    permutations.each do |perm|
      accumulator = numbers.map(&:to_i).reduce(0) do |acc, number|
        if perm[0] == '||'
          perm.shift
          (acc.to_s + number.to_s).to_i
        else
          acc.send(perm.shift, number)
        end
      end
      if accumulator == result
        total += result
        break
      end
    end
  end
  total
end


p challenge_2