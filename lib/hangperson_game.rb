class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word 
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
    self
  end
  
  def guess(letter)
    raise ArgumentError if !(letter =~ /[a-z]{1}/i)
    return false if (@guesses.include? letter.downcase) || (@wrong_guesses.include? letter.downcase)
    if @word.include? letter.downcase
      @guesses << letter.downcase
    else 
      @wrong_guesses << letter.downcase
    end
  end
  
  def word_with_guesses
    displayed = @word
    (displayed.split("")).each do |i|
      if @guesses.include? @word[i]
        displayed[i] = @word[i] 
      else
        displayed[i] = "-"
      end
    end
    return displayed
  end
  
  def check_win_or_lose
    if @word.delete(@guesses).empty?
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else 
      return :play
    end
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
