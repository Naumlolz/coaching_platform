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

def likes(names)
  return 'no one likes this' if names.empty?

  case names.size
  when 1
    "#{names[0]} likes this"
  when 2
    "#{names[0]} and #{names[1]} like this"
  when 3
    "#{names[0]}, #{names[1]} and #{names[2]} like this"
  else
    "#{names[0]}, #{names[1]} and #{names.size - 2} others like this"
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

def tower_combinations(size)
  (1..size).reduce(1, :*)
end

def usdcny(usd)
  number = usd * 6.75
  "#{format('%.2f', number)} Chinese Yuan"
end

def count_correct_characters(correct, guess)
  raise 'This is an exception' if correct.size != guess.size

  correct.chars.zip(guess.chars).count { |c, g| c == g }
end

def validate_number(string)
  string.delete('-').match?(/^(?:\+44|0)7\d{9}$/) ? 'In with a chance' : 'Plenty more fish in the sea'
end

def anagram?(test, original)
  test.downcase.chars.sort.join == original.downcase.chars.sort.join
end

def count_red_beads(num)
  if num < 2
    0
  else
    2 * (num - 1)
  end
end

def vow?(arr)
  arr.map { |o| 'aeoiu'.include?(o.chr) ? o.chr : o }
end

def hydrate(str)
  total_glasses = str.scan(/\d/).map(&:to_i).sum
  glass_or_glasses = total_glasses == 1 ? 'glass' : 'glasses'
  "#{total_glasses} #{glass_or_glasses} of water"
end

def all_possibilities?(arr)
  return false if arr == []

  sorted = arr.sort
  (0..sorted.last).to_a == sorted
end

def find_longest(arr)
  arr.map(&:to_s).max_by(&:length).to_i
end

def cube_checker(volume, side)
  return false if (volume.zero? || side.zero?) || (volume.negative? || side.negative?)

  side**3 == volume
end

def alphabet_war(fight)
  left_side = fight.tr('wpbs', '4321').chars.map(&:to_i).sum
  right_side = fight.tr('mqdz', '4321').chars.map(&:to_i).sum

  if left_side > right_side
    'Left side wins!'
  elsif right_side > left_side
    'Right side wins!'
  else
    "Let's fight again!"
  end
end

def abbrev_name(name)
  name.split.map { |word| word[0].capitalize }.join('.')
end

def how_much_i_love_you(nb_petals)
  petals = {
    1 => 'I love you',
    2 => 'a little',
    3 => 'a lot',
    4 => 'passionately',
    5 => 'madly',
    0 => 'not at all'
  }

  result = nb_petals % 6
  petals[result]
end

def contamination(text, char)
  return '' if text.empty? || char.empty?

  char * text.size
end

def sum_mul(num, mun)
  return 'INVALID' if (num.negative? || mun.negative?) || (num.zero? || mun.zero?) || (mun < num)

  (num..mun).step(num).sum
end

def two_sort(str)
  str.min.chars.join('***')
end

def bin_str(str)
  counts = 0
  while str != '0' * str.size
    idx = str.index('1')
    sliced_str = str.slice(idx..-1).tr('10', '01')
    str = idx.zero? ? sliced_str : str[0...idx] + sliced_str
    counts += 1
  end
  counts
end

def validate_code(code)
  /^[1-3]/.match?(code.to_s)
end

def sort_my_string(str)
  beginning = ''
  ending = ''
  result = ' '
  str.chars.each_with_index { |e, idx| idx.even? ? beginning << e : ending << e }
  beginning + result + ending
end

def find_digit(num, nth)
  num = num.abs
  return -1 if nth <= 0
  return 0 if nth > num.to_s.size

  num.digits[nth - 1]
end

def power_of_two?(num)
  num.positive? && (num & (num - 1)).zero?
end

def men_from_boys(arr)
  evens, odd = arr.uniq.partition(&:even?)
  evens.sort + odd.sort.reverse
end

def tidy_number(num)
  num.digits.uniq.each_cons(2).all? { |f, s| f > s }
end

def largest_pair_sum(numbers)
  numbers.sort.each_cons(2).map(&:sum).max
end

def ordered_count(str)
  str.chars.tally.map(&:to_a)
end

def last(str)
  str.split.sort_by { |word| word[-1] }
end

def outed(meet, boss)
  meet[boss.to_sym] <= 5 ? 'Get Out Now!' : 'Nice Work Champ!'
end

# def unique_in_order(iterable)
#   iterable.empty? ? [] :
#     iterable.is_a?(Array) ? iterable.uniq! : iterable.squeeze.chars
# end

def unique_in_order(iterable)
  return [] if iterable.empty?

  iterable.is_a?(Array) ? iterable.uniq : iterable.squeeze.chars
end

# def solver(str)
#   matchers = []
#   result = [/[A-Z]/, /[a-z]/, /[0-9]/, /[^a-zA-Z0-9]/]
#   result.each { |matcher| matchers << str.scan(matcher).size }
#   matchers
# end

def solver(str)
  [/[A-Z]/, /[a-z]/, /[0-9]/, /[^a-zA-Z0-9]/].map { |matcher| str.scan(matcher).size }
end

# def high(str)
#   position_points = ('a'..'z').zip(1..26).to_h
#   splitted_str = str.split
#   res = []
#   splitted_str.each do |word|
#     temp_res = []
#     word.chars.each do |char|
#       temp_res << position_points[char]
#     end
#     res << temp_res.sum
#   end
#   result = splitted_str.zip(res).to_h
#   result.key(result.values.max)
# end

def high(str)
  alphabet = ('a'..'z').to_a
  scores = str.split.map do |word|
    word.chars.sum { |char| alphabet.index(char) + 1 }
  end
  str.split[scores.index(scores.max)]
end

def sort_array(source_array)
  odd_numbers = source_array.select(&:odd?).sort
  source_array.map { |num| num.odd? ? odd_numbers.shift : num }
end

# def persistence(num)
#   return 0 if num.digits.size == 1

#   counts = 0

#   while num.digits.size != 1
#     num = num.digits.inject(:*)
#     counts += 1
#   end

#   counts
# end

def persistence(num)
  return 0 if num < 10

  count = 0
  loop do
    num = num.digits.reduce(:*)
    count += 1
    break unless num > 9
  end
  count
end

def shorten_to_date(long_date)
  long_date.sub(/,.*$/, '')
end

# def expanded_form(num, base: 10)
#   res = num.to_s.reverse.each_char.with_index.map do |character, index|
#     base**index * character.to_i
#   end.reverse

#   res.delete(0)
#   res.join(' + ')
# end

def expanded_form(num, base: 10)
  num.to_s
     .reverse
     .chars
     .map.with_index { |character, index| base**index * character.to_i }
     .reverse
     .reject(&:zero?)
     .join(' + ')
end

def max_product(numbers, size)
  numbers.sort.reverse.first(size).reduce(:*)
end

def count_chars(str)
  str.chars.tally
end

# def filter_string(string)
#   string.chars.filter { |e| e.match?(/[0-9]/) }.join.to_i
# end

def filter_string(string)
  string.scan(/\d/).join.to_i
end

def explode(str)
  str.chars.map { |e| e * e.to_i }.join
end

def define_suit(card)
  hash = {
    'C': 'clubs',
    'D': 'diamonds',
    'S': 'spades',
    'H': 'hearts'
  }

  hash[card[-1].to_sym]
end

def calc(str)
  total1 = str.chars.map(&:ord).join
  total2 = total1.tr('7', '1')
  total1.to_i.digits.sum - total2.to_i.digits.sum
end

# def vaporcode(string)
#   string.delete(' ').chars.map(&:upcase).join('  ')
# end

def vaporcode(string)
  string.upcase.gsub(/\s/, '').split('').join('  ')
end

def find_smallest(numbers, to_return)
  to_return == 'value' ? numbers.min : numbers.index(numbers.min)
end

def div_con(arr)
  num, strings = arr.partition { |e| e.is_a?(Integer) }
  integers_strings = strings.map(&:to_i)
  num.sum - integers_strings.sum
end

def capitalized(str, ind)
  str.chars.map.with_index { |e, idx| ind.include?(idx) ? e.upcase : e }.join
end
