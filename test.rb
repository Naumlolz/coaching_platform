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
