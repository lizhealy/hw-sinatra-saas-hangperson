class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
 
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end



  def guess(letter)
    case letter
      when nil
        raise ArgumentError
      when ""
        raise ArgumentError
      when /[^a-zA-Z]/
	      raise ArgumentError
      else
    
        letter.downcase!
        
        if @word.include?(letter)
          if !@guesses.include?(letter) && @word.include?(letter)
            @guesses += letter
          else
            return false
          end
        elsif !@word.include?(letter)
          if !@wrong_guesses.include?(letter)
            @wrong_guesses += letter
          else
            return false
          end
        end
      
    end
  end
  

  def check_win_or_lose
    if word_with_guesses == @word
      :win
    elsif @wrong_guesses.length > 6
      :lose
    else
      :play
    end 
  end

  def word_with_guesses
    temp = ''
    @word.each_char do |letter| 
      if @guesses.include?(letter) 
        temp += letter 
      else 
        temp += '-' 
      end 
     end 
     return temp 
    
    
  end

end
