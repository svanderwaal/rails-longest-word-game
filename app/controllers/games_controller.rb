require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @letters_options = params[:letter_options]
    @attempt = (params[:word]).upcase

    response = URI.open("https://wagon-dictionary.herokuapp.com/#{@attempt}")
    json = JSON.parse(response.read)
    @json_answer = json['found']

    @char_answer = @attempt.chars.all? { |letter| @attempt.count(letter) <= @letters_options.count(letter) }

    if @char_answer == true
      if @json_answer == true
        @answer = "Congratulations! #{@attempt.upcase} is a valid word!"
      else
        @answer = "Sorry but #{@attempt.upcase} does not seem to be a valid English word..."
      end
    else
      @answer = "Sorry but #{@attempt.upcase} can't be built out of #{@letters_options}"
    end
  end
end
