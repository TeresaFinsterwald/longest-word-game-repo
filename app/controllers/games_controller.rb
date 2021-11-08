require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.shuffle[0..10]
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    if @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter)}
      response = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}")
      json = JSON.parse(response.read)
      if json['found'] == true
        @answer = "Congrats! #{@word} is correct!"
      else
        @answer = "#{@word} is no english word!"
      end
    else
      @answer = "#{@word} is not in the grid!"
    end
  end
end
