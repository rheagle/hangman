class Hangman


  def initialize
    @setup = Setup.new
    @guesses_left = 7
    @word_picked = @setup.pick_word
    @blanks = @setup.blank_array(@word_picked)
    #@blanks = Array.new(@word_picked.length, "_").join(" ") # Create array of '_' the length of the word
    @letters = ("a".."z").to_a
  end

  def display_board
    p @word_picked # DELETE this line later
    puts "\n"
    puts @blanks.join(" ")

  end


 # def get_guess

 # end
end




