def lesson_a
  file = File.open "../input.txt"

  lines = file.readlines

  common_items = Array.new

  lines.each do |line|
    known_char = Hash.new
    first_compartment = line[0, line.length / 2]
    second_compartment = line[line.length / 2, line.length]
    first_compartment.each_char do |char|
      known_char.store char, true
    end

    second_compartment.each_char do |char|
      if known_char.has_key? char
        common_items.push char
        break
      end
    end

  end

  count = 0
  common_items.each do |char|
    ord = char.ord
    if ord > 96
      count += ord - 96
    else
      count += ord - 38
    end
  end

  puts count
end

def lesson_b
  file = File.open "../input.txt"

  lines = file.readlines

  common_items = Array.new
  group_count = 1
  known_char = Hash.new
  known_char_round = Hash.new

  lines.each do |line|
    line.each_char do |char|
      if known_char.has_key? char
        if !known_char_round.has_key? char
          known_char[char] += 1
        end
      else
        known_char.store char, 1
      end
      known_char_round.store char, true
    end

    known_char_round.clear

    if group_count == 3
      if known_char.has_value? 3
        common_items.push known_char.key 3
      end
      known_char.clear
      group_count = 1
      next
    end

    group_count += 1
  end

  count = 0
  common_items.each do |char|
    ord = char.ord
    if ord > 96
      count += ord - 96
    else
      count += ord - 38
    end
  end

  puts count
end

lesson_a
lesson_b
