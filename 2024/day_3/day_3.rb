@input = File.read('2024/day_3/day_3_input.txt')


def challenge_1
  mul_instructions = @input.scan(/mul\(\d{1,3},\d{1,3}\)/)
  numbers_to_multiply = mul_instructions.map { |instruction| instruction.scan(/\d{1,3}/).map(&:to_i) }
  result = 0
  numbers_to_multiply.each do |numbers|
    result += numbers[0] * numbers[1]
  end
  result
end

p challenge_1

def challenge_2
  enabled = true
  total = 0
  @input.scan(/(do\(\)|don't\(\))|mul\((\d+),(\d+)\)/).each do |instruction, x, y|
    if instruction
      enabled = (instruction == "do()")
    else
      total += x.to_i * y.to_i if enabled
    end
  end

  total
end

p challenge_2


