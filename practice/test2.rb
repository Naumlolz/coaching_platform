def high(str)
  position_points = ('a'..'z').zip(1..26).to_h
  splitted_str = str.split
  res = []
  splitted_str.each do |word|
    temp_res = []
    word.chars.each do |char|
      temp_res << position_points[char]
      temp_res
    end
    res << temp_res.sum
  end
  result = splitted_str.zip(res).to_h
  result.key(result.values.max)
end

def persistence(num)
  return 0 if num.digits.size == 1
  counts = 0

  while num.digits.size != 1 do
    num = num.digits.inject(:*)
    counts += 1
  end
  
  counts
end

persistence(39)
