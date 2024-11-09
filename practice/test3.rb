# frozen_string_literal: true

def automorphic(num)
  (num**2).to_s.end_with?(num.to_s) ? 'Automorphic' : 'Not!!'
end

def unlucky_days(year)
  count = 0

  (1..12).each do |month|
    count += 1 if Date.new(year, month, 13).friday?
  end

  count
end

def incrementer(nums)
  b = nums.map.with_index { |e, idx| e + 1 * (idx + 1) }
  b.map.with_index { |e, idx| p b[idx] >= 10 ? e % 10 : e }
end

def delete_nth(order, max_e)
  result = []

  order.each do |e|
    next if result.count(e) >= max_e

    result.push(e)
  end

  result
end

# def delete_nth(order, max_e)
#   order.group_by(&:itself).transform_values { |v| v.take(max_e) }.values.flatten
# end

def all?(array, &block)
  array.all?(&block)
end

def multiply(num)
  power = num.abs.digits.size
  num * 5**power
end

def dashatize(num)
  int = num.abs.digits.reverse
  int.map do |e|
    e.even? ? e.to_s : "-#{e}-"
  end

  dashatize_result(int)
end

def dashatize_result(arr)
  res = arr.join
  res.gsub!(/^-+|-+$|(-)\1+/, '\1')
  res
end

def sum_of_integers_in_string(str)
  str.scan(/[0-9]+/).map(&:to_i).sum
end

def highest_rank(arr)
  res = arr.group_by(&:itself).transform_values(&:count)
  max_occur = res.values.max
  res.select { |_, v| v == max_occur }.keys.max
end

def solve(str)
  arr = str.tr!('aeiuo', ' ').split(' ')

  solve_iterator(arr)
end

def solve_iterator(arr)
  hash = Hash[('a'..'z').zip((1..26).to_a)]
  res = []

  arr.each do |e|
    c = 0
    e.each_char { |i| c += hash[i] }
    res.push(c)
  end

  res.max
end

# def solve2(arr)
#   hash = Hash[('a'..'z').zip((1..26).to_a)]
#   arr.map!(&:downcase)

#   res = []

#   arr.each do |e|
#     count = 0
#     e.each_char.with_index { |i, idx| count += 1 if idx + 1 == hash[i] }
#     res.push(count)
#   end

#   res
# end

def solve2(arr)
  hash = Hash[('a'..'z').zip((1..26).to_a)]
  arr.map!(&:downcase)

  arr.map do |e|
    e.each_char.with_index.count { |i, idx| idx + 1 == hash[i] }
  end
end

# def gps(spd, arr)
#   return 0 if arr.length <= 1

#   res = []
#   arr.each_cons(2) { |e| res.push((e[1] - e[0]).round(2)) }
#   res.map { |e| ((3600 * e) / spd).floor }.max
# end

def gps(spd, arr)
  return 0 if arr.length <= 1

  arr.each_cons(2).map { |e| ((3600 * (e[1] - e[0]).round(2)) / spd).floor }.max
end

def tower_builder(n_floors)
  fund = n_floors * 2 - 1
  (1..fund).step(2).map { |e| ('*' * e).center(fund) }
end

def discover_original_price(discounted_price, sale_percentage)
  (discounted_price / (100 - sale_percentage.to_f) * 100).round(2)
end

def extra_perfect(num)
  (1..num).step(2).to_a
end

def max_gap(numbers)
  numbers.sort.each_cons(2).map { |a, b| b - a }.max
end
