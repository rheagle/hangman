class SaveGame
  
  SAVE_DIR = "saved_games" # Stores saved games in dedicated folder


  def initialize
    Dir.mkdir(SAVE_DIR) unless Dir.exist?(SAVE_DIR)
  end


  def save_current_game(game_state, filename)
    file_path = File.join(SAVE_DIR, "#{filename}.dat")
    File.open(file_path, "wb") { |file| Marshal.dump(game_state, file) }
    puts "Game saved as '#{filename}'. Exiting..."
  end


  def list_saved_games
    saved_games = Dir.glob(File.join(SAVE_DIR, "*.dat")).map { |file| File.basename(file, ".dat") }
    if saved_games.empty?
      puts "No saved games found."
      return []
    end

    puts "Available saved games:"
    saved_games.each_with_index { |name, index| puts "#{index + 1}: #{name}" }
    saved_games
  end


  def load_game
    saved_games = list_saved_games
    return nil if saved_games.empty?

    print "Enter the number of the game you want to load: "
    choice = gets.chomp.to_i - 1

    if choice.between?(0, saved_games.length - 1)
      file_path = File.join(SAVE_DIR, "#{saved_games[choice]}.dat")
      File.open(file_path, "rb") { |file| return Marshal.load(file) }
    else
      puts "Invalid choice."
      nil
    end
  end



      

end