class GamesController < ApplicationController
  def new
    @letters = []
    letter = 10.times do |l|
      l = ("a".."z").to_a.sample
      @letters << l
    end
  end

  def score
  end
end
