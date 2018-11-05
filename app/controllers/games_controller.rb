require 'open-uri'
# Games controller
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
    grid = params['grid'].split
    user_word = params['user_input']
    if !check_is_the_word_exists(user_word)
      @feedback = 'this word does not exists'
    elsif !valid_grid?(user_word, grid)
      @feedback = "this word doesn't match, dude"
    else
      @feedback = 'cool'
    end
  end
end
