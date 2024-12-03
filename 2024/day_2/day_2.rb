require 'pry'

@reports = []

File.foreach('2024/day_2/day_2_input.txt') do |line|
  @reports << line.gsub("\n", '')
end

def same_sign?(previous, current)
  return true if previous.nil?

  previous == current
end

def sequence_safe?(numbers)
  previous_sign = nil

  numbers.each_cons(2) do |previous_number, current_number|
    difference = current_number - previous_number
    current_sign = difference.positive? ? :positive : :negative
    within_range = difference.abs.between?(1, 3)

    return false unless within_range && same_sign?(previous_sign, current_sign)

    previous_sign = current_sign
  end

  true
end

def safe?(report, error_tolerance = false)
  numbers = report.split.map(&:to_i)

  return true if sequence_safe?(numbers)

  if error_tolerance
    numbers.each_with_index do |_, index|
      binding.pry
      modified_numbers = numbers.dup
      modified_numbers.delete_at(index)
      return true if sequence_safe?(modified_numbers)
    end
  end

  false
end

def challenge_1
  safe_reports = 0
  @reports.each do |report|
    safe_reports += 1 if safe?(report)
  end

  safe_reports
end

p challenge_1


def challenge_2
  safe_reports = 0
  @reports.each do |report|
    safe_reports += 1 if safe?(report, true)
  end

  safe_reports
end

p challenge_2



