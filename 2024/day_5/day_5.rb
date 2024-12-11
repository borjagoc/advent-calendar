require 'pry'

@rules = File.foreach('2024/day_5/day_5_rules_input.txt').map { |line| line.chomp }

def correct_order?(list)
  array = []
  list.each do |number|
    @rules.each do |rule|
      numbers = rule.split("|")
      left_number = numbers[0]
      right_number = numbers[1]
      if left_number == number
        if array.include?(right_number)
          return false
        else
          array << number
        end
      end
    end
  end
  return true
end

def lists_in_correct_order
  lists_in_correct_order = []
  File.foreach('2024/day_5/day_5_list_input.txt').each do |line|
    list = line.chomp.split(',')
    lists_in_correct_order << list if correct_order?(list)
  end
  lists_in_correct_order
end

def challenge_1
  total = 0
  lists_in_correct_order.each do |list|
    middle_number = list[list.size / 2]
    total += middle_number.to_i
  end
  total
end

p challenge_1


def lists_in_incorrect_order
  lists_in_incorrect_order = []
  File.foreach('2024/day_5/day_5_list_input.txt').each do |line|
    list = line.chomp.split(',')
    lists_in_incorrect_order << list unless correct_order?(list)
  end
  lists_in_incorrect_order
end


def rules_for_number(number)
  @rules.select do |rule|
    rule_array = rule.split("|")
    rule_array[0].to_i == number || rule_array[1].to_i == number
  end
end

def update_list(list,rules)
  rules.each do |rule|
    rule_array = rule.split("|")
    left_number = rule_array[0]
    right_number = rule_array[1]
    left_index = list.find_index(left_number)
    right_index = list.find_index(right_number)
    next unless left_index && right_index
    if left_index > right_index
      list.insert(left_index, list.delete_at(right_index))
    end
  end
  list
end


def rearranged_lists
  rearranged_lists = []
  lists_in_incorrect_order.each do |list|
    rules = []
    list.map(&:to_i).each do |number|
      rules << rules_for_number(number)
    end
    updated_list = update_list(list, rules.flatten)
    rearranged_lists << updated_list
  end
  rearranged_lists
end


def challenge_2
  total = 0
  rearranged_lists.each do |list|
    middle_number = list[list.size / 2]
    total += middle_number.to_i
  end
  total
end

p challenge_2