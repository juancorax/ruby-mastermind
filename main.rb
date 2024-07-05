require_relative 'lib/player'
require_relative 'lib/computer'

def compare_code(secret_code_array, player_guess_array)
  secret_code_copy = secret_code_array.clone
  player_guess_copy = player_guess_array.clone

  exactly_correct = 0

  (0..3).each do |index|
    next unless secret_code_copy[index] == player_guess_copy[index]

    secret_code_copy[index] = nil
    player_guess_copy[index] = nil

    exactly_correct += 1
  end

  if exactly_correct == 4
    puts '----- You have guessed the code! -----'

    true
  else
    puts "#{exactly_correct} colors are exactly correct"

    wrong_space = 0

    player_guess_copy.each do |color|
      next if color.nil?

      color_index = secret_code_copy.index(color)

      next unless color_index

      secret_code_copy[color_index] = nil

      wrong_space += 1
    end

    puts "#{wrong_space} colors are in the wrong space\n\n"

    false
  end
end

def start_game
  player = Player.new
  computer = Computer.new

  turn = 1

  secret_code = computer.generate_code

  while turn <= 12
    puts "----- #{13 - turn} turn(s) left -----\n\n"

    player_guess = player.guess_code

    puts "Your guess is: #{player_guess.join(' ')}\n\n"

    return if compare_code(secret_code, player_guess)

    turn += 1
  end

  puts "----- You have lost! -----\n\n"
  puts "Secret code: #{secret_code.join(' ')}"
end

start_game
