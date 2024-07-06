require_relative 'lib/player'
require_relative 'lib/computer'

def compare_code(secret_code_array, player_guess_array)
  secret_code_copy = secret_code_array.clone
  player_guess_copy = player_guess_array.clone

  exactly_correct = 0
  exactly_correct_indexes = []

  (0..3).each do |index|
    next unless secret_code_copy[index] == player_guess_copy[index]

    secret_code_copy[index] = nil
    player_guess_copy[index] = nil

    exactly_correct += 1
    exactly_correct_indexes << index
  end

  if exactly_correct == 4
    puts '----- You have guessed the code! -----'

    'success'
  else
    puts "#{exactly_correct} colors are exactly correct"

    wrong_space = 0
    wrong_space_indexes = []

    player_guess_copy.each_with_index do |color, index|
      next if color.nil?

      color_index = secret_code_copy.index(color)

      next unless color_index

      secret_code_copy[color_index] = nil

      wrong_space += 1
      wrong_space_indexes << index
    end

    puts "#{wrong_space} colors are in the wrong space\n\n"

    [exactly_correct_indexes, wrong_space_indexes]
  end
end

def start_game
  player = Player.new
  computer = Computer.new

  turn = 1

  secret_code_creator = ''

  until [1, 2].include?(secret_code_creator)
    puts 'Who do you want to be?:'
    puts '1: Creator of the code | 2: Guesser of the code'

    print '>> '
    secret_code_creator = gets.chomp.to_i
    puts "\n"
  end

  if secret_code_creator == 1
    secret_code = player.select_code

    puts "Secret code: #{secret_code.join(' ')}\n\n"
  else
    secret_code = computer.generate_code
  end

  last_guess = []
  feedback = ''

  while turn <= 12
    puts "----- #{13 - turn} turn(s) left -----\n\n"

    guess = if secret_code_creator == 1
              computer.guess_code(last_guess, feedback)
            else
              player.select_code
            end

    last_guess = guess

    puts "Your guess is: #{guess.join(' ')}\n\n"

    feedback = compare_code(secret_code, guess)

    return if feedback == 'success'

    turn += 1
  end

  puts "----- You have lost! -----\n\n"
  puts "Secret code: #{secret_code.join(' ')}"
end

start_game
