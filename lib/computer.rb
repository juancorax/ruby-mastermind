require_relative 'colors'

class Computer < Colors
  def generate_code
    code = []

    code << colors.sample while code.length < 4

    code
  end

  def guess_code(last_guess_array, feedback_array)
    if last_guess_array.empty?
      guess = Array.new(4, colors[0])
    else
      guess = Array.new(4, nil)

      feedback_array[0].each do |index|
        guess[index] = last_guess_array[index]
      end

      (0..3).each do |index|
        next unless guess[index].nil?

        if feedback_array[1].length.positive?
          feedback_array[1].each do |wrong_space_index|
            next if index == wrong_space_index

            guess[index] == colors[colors.index(last_guess_array[wrong_space_index])]
            feedback_array[1].delete_at(feedback_array[1].index(wrong_space_index))
            break
          end
        else
          guess[index] = colors[colors.index(last_guess_array[index]) + 1]
        end
      end
    end

    guess
  end
end
