# frozen_string_literal: true

def find_needle(haystack)
  "found the needle at position #{haystack.index('needle')}"
end

def switch_it_up(number)
  numbers = {
    0 => 'Zero', 1 => 'One',
    2 => 'Two', 3 => 'Three',
    4 => 'Four', 5 => 'Five',
    6 => 'Six', 7 => 'Seven',
    8 => 'Eight', 9 => 'Nine'
  }
  numbers[number]
end

def smash(words)
  words.join(' ')
end

def rental_car_cost(days)
  if days < 3
    days * 40
  elsif days.between?(3, 6)
    days * 40 - 20
  else
    days * 40 - 50
  end
end

def remove_every_other(arr)
  arr.each_slice(2).map(&:first)
end

def isogram?(str)
  str.downcase.each_char.uniq.size == str.downcase.size
end

def opposite(num)
  -num
end

def powers_of_two(num)
  result = []
  (0..num).to_a.each do |n|
    result << 2**n
  end
  result
end

def number(lines)
  num = 1
  arr = []
  lines.each do |line|
    arr << "#{num}: #{line}"
    num += 1
  end
  arr
end

def simple_multiplication(number)
  number.even? ? number * 8 : number * 9
end

def twice_as_old(dad, son)
  (dad - son * 2).abs
end

def find_next_square(sqr)
  num = Math.sqrt(sqr)
  if num == num.to_i
    num.to_i.succ**2
  else
    -1
  end
end

def square_sum(numbers)
  num = 0
  numbers.each do |number|
    num += number**2
  end
  num
end

def divisors(num)
  sum = 0
  (1..num).to_a.each do |el|
    sum += 1 if (num % el).zero?
  end
  sum
end

def str_count(word, letter)
  word.count(letter)
end

def dna_to_rna(dna)
  dna.gsub('T', 'U')
end

def sum(numbers)
  numbers.sum
end

def correct(string)
  string.tr('501', 'SOI')
end

def between(start, ending)
  (start..ending).to_a
end

# class which alternating string case
class String
  def to_alternating_case
    swapcase
  end
end

def zero_fuel(distance, mpg, fuel_left)
  distance <= mpg * fuel_left
end

def test_even(num)
  num.ceil.even?
end

def palindrome?(str)
  str.downcase.reverse == str.downcase
end

def sort_by_length(arr)
  arr.sort_by(&:length)
end

def sum_str(str1, str2)
  (str1.to_i + str2.to_i).to_s
end

def summation(num)
  (1..num).to_a.sum
end

def fake_bin(str)
  str.tr('01234', '0').tr('56789', '1')
end

def quarter_of(month)
  if month.between?(1, 3)
    1
  elsif month.between?(4, 6)
    2
  elsif month.between?(7, 9)
    3
  else
    4
  end
end

def final_grade(exam, projects)
  if exam >= 90 || projects > 10
    100
  elsif exam > 75 && projects >= 5
    90
  elsif exam > 50 && projects >= 2
    75
  else
    0
  end
end

def sale_hotdogs(num)
  if num < 5
    num * 100
  elsif num.between?(5, 9)
    num * 95
  else
    num * 90
  end
end

def say_hello(name)
  "Hello, #{name}"
end

def move(position, roll)
  roll * 2 + position
end

def goose_filter(birds)
  geese = ['African', 'Roman Tufted', 'Toulouse', 'Pilgrim', 'Steinbacher']
  birds.filter { |e| !geese.include?(e) }
end

def find_difference(arr, brr)
  (arr.reduce(:*) - brr.reduce(:*)).abs
end

def remove_char(str)
  str.delete_prefix(str[0]).delete_suffix(str[-1])
end

def shortcut(str)
  str.tr('aeuio', '')
end

def arithmetic(int1, int2, operator)
  case operator
  when 'add'
    int1 + int2
  when 'subtract'
    int1 - int2
  when 'multiply'
    int1 * int2
  else
    int1 / int2
  end
end

def enough(cap, on, wait)
  on + wait <= cap ? 0 : (cap - (on + wait)).abs
end

def find_multiples(integer, limit)
  (integer..limit).step(integer).to_a
end

def capitals(word)
  capital_indices = []

  word.each_char.with_index do |char, index|
    capital_indices << index if char == char.upcase && !'1234567890'.include?(char)
  end

  capital_indices
end

def reverse_list(list)
  list.reverse
end

def remove_url_anchor(url)
  url.include?('#') ? url.delete_suffix(url[url.index('#')..]) : url
end

def gimme(input_array)
  arr = input_array.sort
  input_array.index(arr[1])
end

def positive_sum(arr)
  arr.filter(&:positive?).sum
end

def count_sheeps(array)
  array.count(true)
end

def nb_dig(num, digit)
  (0..num).to_a.map { |e| e**2 }.map(&:to_s).join.count(digit.to_s)
end

def bin_to_dec(str)
  str.to_i(2)
end

def replace(str)
  str.tr('aeiouAEIOU', '!')
end

# rubocop:disable Metrics/MethodLength

def calculate_years(principal, interest, tax, desired)
  years = 0
  if desired > principal
    while principal <= desired
      income = principal * interest
      principal += income - (income * tax)
      years += 1
    end
    years
  else
    0
  end
end

def human_years_cat_years_dog_years(human_years)
  dog_years = 0
  cat_years = 0
  case human_years
  when 1
    dog_years = 15
    cat_years = 15
  when 2
    dog_years = 24
    cat_years = 24
  else
    dog_years = 24 + (5 * (human_years - 2))
    cat_years = 24 + (4 * (human_years - 2))
  end
  [human_years, cat_years, dog_years]
end

def check_exam(arr1, arr2)
  result = 0
  arr1.zip(arr2).each do |el|
    if el[0].empty? || el[1].empty?
      result += 0
    elsif el[0] == el[1]
      result += 4
    else
      result -= 1
    end
  end

  result.negative? ? 0 : result
end

def capitalize(str)
  str1 = ''
  str2 = ''

  chr = str.chars
  chr.each_with_index do |el, idx|
    if idx.even?
      str1 << el.upcase
      str2 << el
    else
      str2 << el.upcase
      str1 << el
    end
  end

  [str1, str2]
end

def get_grade(sc1, sc2, sc3)
  aver = (sc1 + sc2 + sc3) / 3
  if aver >= 90
    'A'
  elsif aver.between?(80, 89)
    'B'
  elsif aver.between?(70, 79)
    'C'
  elsif aver.between?(60, 69)
    'D'
  else
    'F'
  end
end

# rubocop:enable Metrics/MethodLength

def merge_arrays(arr1, arr2)
  (arr1 + arr2).uniq.sort
end

def xor(el1, el2)
  el1 != el2
end

def solve(str)
  lowers = str.count(('a'..'z').to_a.join)
  uppers = str.count(('A'..'Z').to_a.join)

  uppers > lowers ? str.upcase : str.downcase
end

def encode(str)
  str.tr('aeiou', '12345')
end

def decode(str)
  str.tr('12345', 'aeiou')
end

def get_sum(int1, int2)
  int2 < int1 ? (int2..int1).to_a.sum : (int1..int2).to_a.sum
end

def solve_arr(arr)
  arr.reverse.uniq.reverse
end

def plural(num)
  num != 1
end

def add_length(str)
  str.split.map { |el| "#{el} #{el.length}" }
end

def first_non_consecutive(arr)
  arr.each_cons(2) do |el|
    return el[1] if el[1] - el[0] != 1
  end
end

def comp(array1, array2)
  if array1.nil? || array2.nil?
    false
  else
    c = array1.sort.zip(array2.sort)
    d = c.collect { |e| e[1] == e[0]**2 }
    d.all?(true)
  end
end

def open_or_senior(data)
  data.map { |el| el[0] >= 55 && el[1] > 7 ? 'Senior' : 'Open' }
end

def high_and_low(numbers)
  numbers.split(' ').map(&:to_i).minmax.reverse.join(' ')
end

def multi_table(number)
  initial = 1
  result = ''
  10.times do |_|
    result += "#{initial} * #{number} = #{initial * number}\n"
    initial += 1
  end
  result.chomp
end

def multi_table2(number)
  (1..10).map { |initial| "#{initial} * #{number} = #{initial * number}" }.join("\n")
end

def row_weights(array)
  sum_even = 0
  sum_odd = 0
  array.each.with_index { |el, idx| idx.even? ? sum_even += el : sum_odd += el }

  [sum_even, sum_odd]
end

def row_weights2(arr)
  arr.partition.with_index { |_, idx| idx.even? }.map(&:sum)
end

def find_average(nums)
  nums.sum.fdiv(nums.size)
end

def solution(nums)
  nums.nil? ? [] : nums.sort
end

def small_enough(arr, limit)
  arr.collect { |el| el <= limit }.all?(true)
end

def words_to_marks(string)
  a = ('a'..'z')
  b = (1..26)
  sum = 0
  c = a.to_a.zip(b.to_a).to_h
  string.chars.each do |el|
    sum += c[el]
  end
  sum
end

def min_value(digits)
  number = ''
  uniq_digits = digits.uniq
  number << uniq_digits.delete(uniq_digits.min).to_s until uniq_digits.empty?

  number.to_i
end

def sequence_sum(begin_number, end_number, step)
  begin_number <= end_number ? (begin_number..end_number).step(step).to_a.sum : 0
end

def even_numbers(arr, num)
  arr.select(&:even?).last(num)
end

def sum_of_differences(arr)
  sum = 0
  arr.sort.each_cons(2) do |el|
    sum += (el[0] - el[1])
  end
  sum.abs
end

def find_uniq(arr)
  arr.tally.key(1)
end

def predict_age(*ages)
  (Math.sqrt(ages.collect { |e| e * e }.reduce(:+)) / 2).floor
end

def mxdiflg(arr1, arr2)
  if arr1.empty? || arr2.empty?
    -1
  else
    max_diff_first_arr = (arr1.collect(&:size).min - arr2.collect(&:size).max).abs
    max_diff_scnd_arr = (arr2.collect(&:size).min - arr1.collect(&:size).max).abs
    [max_diff_first_arr, max_diff_scnd_arr].max
  end
end

def bump(arg)
  arg.count('n') <= 15 ? 'Woohoo!' : 'Car Dead'
end

def adjacent_element_product(array)
  array.each_cons(2).map { |e| e[0] * e[1] }.max
end

def generate_shape(num)
  res = ''
  num.times do
    res << "#{'+' * num}\n"
  end
  res.chomp
end

def sum_cubes(num)
  (1..num).reduce { |sum, n| sum + n**3 }
end

def vowel_indices(word)
  indexes = []

  word.downcase.chars.each_with_index do |el, idx|
    indexes << idx + 1 if 'aeuioy'.include?(el)
  end

  indexes
end

def factorial(num)
  num.zero? ? 1 : (1..num).reduce(:*)
end

def vert_mirror(strng)
  strng.split("\n").map(&:reverse).join("\n")
end

def hor_mirror(strng)
  strng.split("\n").reverse.join("\n")
end

def oper(fct, str)
  fct.call(str)
end

# def sorted_and_how?(arr)
#   arr == arr.sort ? 'yes, ascending' : arr == arr.sort.reverse ? 'yes, descending' : 'no'
# end

def sum_of_minimums(numbers)
  numbers.collect(&:min).sum
end

def repeats_my_version(arr)
  arr.tally.to_a.filter { |e| e[1] == 1 }.flatten.filter { |e| e != 1 }.sum
end

def repeats(arr)
  arr.tally.select { |_, v| v == 1 }.sum(&:first)
end

def product_array(numbers)
  result = []
  numbers.combination(numbers.size - 1) do |number|
    result << number.reduce(:*)
  end
  result.reverse
end

def odd_ones_out(numbers)
  numbers.filter { |e| numbers.count(e).even? }
end

def sum_triangular_numbers(num)
  sum = 0
  (1..num).to_a.each do |e|
    sum += (1..e).to_a.sum
  end
  sum
end

def sum_triangular_numbers_v2(num)
  (1..num).reduce(0) do |sum, e|
    sum + (e * (e + 1)) / 2
  end
end

def remove(str)
  str.delete_suffix!('!') while str[-1] == '!'

  str
end

def duplicate_count(text)
  text.downcase.chars.tally.filter { |_, v| v != 1 }.keys.count
end

def round_to_next5(num)
  return num if (num % 5).zero?

  rounded = num.round(-1)
  rounded > num ? rounded : rounded + 5
end
