class Hangman


  def initialize
    @setup = Setup.new
    @guesses_left = 7
    @word = @setup.pick_word
    @blanks = @setup.blank_array(@word)
    @alpha = ("a".."z").to_a
    @used_alpha = [] # Storage for guessed letters
  end


  def display_board
    p @word # DELETE this line later
    puts "\n"
    puts @blanks.join(" ") # Print lines & correct letters
    puts "\n"
    puts @alpha.join(" ") # Print letters a-z (white = unused, red = wrong, green = correct)
    puts "You have #{@guesses_left} strikes left."
  end


  def get_guess
    loop do
      print "Enter your guess: "
      @guess = gets.chomp.downcase

      # Check if guess is valid, ask again if it's not
      if valid_guess?(@guess)
        @used_alpha << @guess # Add guess to used letters
        return @guess
      else
        puts "Invalid guess. Enter a single unused letter."
      end
    end
  end


  def valid_guess?(input)
    input.match?(/\A[a-z]\z/) && !@used_alpha.include?(input)
  end


  def update_blanks
    @word.each_with_index do |letter, index|
      if letter == @guess
        @blanks[index] = letter # Replace "_" with letter if correct
      end
    end
  end


  def update_letters
    # Check if guess is in the word
    if @word.include?(@guess)
      index = @alpha.index(@guess) 
      @alpha[index] = @guess.colorize(:green) # Colorize guess green since it was correct
    else
      # If guess is not in the word...
      index = @alpha.index(@guess)
      @alpha[index] = @guess.colorize(:red) # Colorize it red since it was wrong
      @guesses_left -= 1
    end
  end


  def game_over?
    !@blanks.include?("_") || @guesses_left == 0
  end


  def declare_winner
    if @blanks == @word
      puts "You guessed it! Nice work!"
    else
      puts "Game over. You lost :("
    end
  end


  def play_turn
    get_guess

    update_blanks

    update_letters

    display_board
  end


  def start
    puts "Let's play Hangman! I have picked a word..."
    display_board

    while !game_over?
      play_turn
    end

    declare_winner
  end

end




