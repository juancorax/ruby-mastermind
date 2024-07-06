require_relative 'colors'

class Player < Colors
  def select_code
    code = []
    all_colors = false

    until all_colors
      number_of_colors = 0

      puts "Type 4 of the following colors:\n(separated by spaces & may be repeated)\n\n"
      puts "#{colors.join(' ')}\n\n"

      print '>> '
      code = gets.chomp.split(' ')
      puts "\n"

      code.each do |color|
        number_of_colors += 1 if colors.include?(color)
      end

      all_colors = true if number_of_colors == 4
    end

    code
  end
end
