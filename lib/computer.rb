require_relative 'colors'

class Computer < Colors
  def generate_code
    code = []

    code << colors.sample while code.length < 4

    code
  end
end
