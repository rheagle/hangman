class Hangman
  

  def initialize
    @setup = Setup.new
    @save_game = SaveGame.new
    @guesses_left = 7
    @word = @setup.pick_word
    @blanks = @setup.blank_array(@word)
    @alpha = ("a".."z").to_a
    @used_alpha = [] # Storage for guessed letters
  end


  def display_board
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

  def main_menu
    puts "Let's play Hangman!"
    puts "1. Start new game"
    puts "2. Load saved game"
   
    menu_choice = gets.chomp.to_i

    if menu_choice == 1
      start
    elsif menu_choice == 2
      loaded_game = @save_game.load_game
      if loaded_game
        puts "Game loaded successfully!"
        loaded_game.start
      else
        puts "Failed to load game."
      end
    else
      puts "Invalid choice. Enter '1' to start a new game, enter '2' to load a saved game."
    end
    
  end


  def continue_save
    puts "Press 'S' to save game, or enter to continue playing."
    continue_choice = gets.chomp.upcase
    if continue_choice == 'S'
      print "Enter a name for your save file: "
      filename = gets.chomp
      @save_game.save_current_game(self, filename)
      exit
    end
    false
  end


  def play_turn
    return if continue_save # Exit play_turn if game was saved

    get_guess
    update_blanks
    update_letters
    display_board
  end


  def start
    display_board

    while !game_over?
      play_turn
    end

    declare_winner
  end

end




