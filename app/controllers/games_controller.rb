require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def included?
    @answer.chars.sort.all? { |letter| @grid.include?(letter) }
  end

  def english_word
    response = URI.parse("https://wagon-dictionary.herokuapp.com/#{@answer}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def score
    @answer = params[:word]
    @grid = params[:grid]

    if included? == false
      @result = "Sorry but #{@answer} can't be built of #{@grid}."
    elsif included? && english_word == false
      @result = "Sorry but #{@answer} does not seem to be a vallid English word..."
    elsif included? && english_word
      @result = "Congratulation! #{@answer} is a valid English word."
    end
  end
end
