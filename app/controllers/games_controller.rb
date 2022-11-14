require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    # get the letters
    @letters = params[:letters].split
    # get the word typed by user
    @word = params[:word]
    # to check if the word is included in the letters provided
    @included = @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }
    # to verify if the word is a valid english word or not
    @valid_english = valid_english?(@word)
  end

  private

  def valid_english?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
