class Hangman

  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses

  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  
  def self.random_word
    DICTIONARY.sample()
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(char)
    if @attempted_chars.include?(char)
      return true 
    else 
      return false
    end
  end

  def get_matching_indices(char)
    arr = []
    @secret_word.each_char.with_index do |c, i|
      if c == char 
        arr << i
      end
    end
    arr
  end

  def fill_indices(char, arr)
    arr.each do |indices|
      @guess_word[indices] = char
    end
  end

  def try_guess(char)
    if self.already_attempted?(char)
      print "that has already been attempted"
      return false
    else 
      @attempted_chars << char 
      if get_matching_indices(char).length == 0
        @remaining_incorrect_guesses -= 1
      else 
        self.fill_indices(char, get_matching_indices(char))
      end
      return true 
    end
    
  end

  def ask_user_for_guess
    print "Enter a char:"
    user_guess = gets.chomp
    self.try_guess(user_guess)

  end

  def win?
    if @guess_word.join("") == @secret_word
      print "WIN"
      return true 
    else 
      return false 
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      print "LOSE"
      return true 
    else
      return false
    end
  end


  def game_over?
    if self.win? || self.lose? 
      print @secret_word
      return true 
    else
      return false 
    end
  end

end
