require 'open-uri'
# Games controller

LETTER_SCORE = {
  '1' => %w('a', 'e', 'i', 'o', 'n', 'r', 't', 'l', 's', 'u'),
  '2' => %w('d','g'),
  '3' => %w('b', 'c', 'm', 'p'),
  '4' => %w('f', 'h', 'v', 'w', 'y'),
  '5' => %w('k'),
  '8' => %w('j', 'x'),
  '10' => %w('q', 'z')
}

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('a'..'z').to_a.sample
    end
    # render new.html.erb
  end

  def check_is_the_word_exists(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt.downcase}"
    serialized = open(url).read
    data = JSON.parse(serialized)
    data['found']
  end

  def valid_grid?(attempt, grid)
    splitted_word = attempt.downcase.split('')
    valid_grid = true
    splitted_word.each do |letter|
      valid_grid = false unless grid.include?(letter)
      grid.delete_at(grid.index(letter)) if grid.include?(letter)
    end
    valid_grid
  end

  def score
    grid = params['grid'].downcase.split('')
    user_word = params['user_input']
    @feedback = if !check_is_the_word_exists(user_word)
                  'hey dude, this word does not even exists'
                elsif !valid_grid?(user_word, grid)
                  "#{user_word} doesn't match with #{grid}. are you stupid ?"
                else
                  'cool, you won.'
                end
  end

  def results
    user_word = params['user_input'].split('')
    user_word.each do |letter|
      LETTER_SCORE.value?(letter)
    end
  end
end


