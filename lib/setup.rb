
class Setup
  #MAX_GUESSES = 7

  def initialize
    @words = File.readlines('dictionary.txt').map(&:strip)
    
  end

  def pick_word
    # Filter words to only 5 - 12 characters long
    word_options = @words.select { |word| word.length >= 5 && word.length <=12 }
    word_options.sample.chars # Choose random word & split into an array
  end

  def blank_array(word)
    Array.new(word.length, "_")
  end

=begin
  def display_board(blanks)
    puts ""
    puts blanks.join(" ")
  end
=end

    

 # def start



end