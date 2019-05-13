require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
    @start_time = Time.now
  end

  def score
    @score = params['word']
    @letters = params['grid']
    @start_time = DateTime.parse(params['start_time'])
    def word_in_grid?(attempt, grid)
      attempt.upcase!.split('').all? { |letter| attempt.count(letter) <= grid.count(letter) }
    end

    def run_game(attempt, grid, start_time, end_time)
      # TODO: runs the game and return detailed hash of result
      start_time = @start_time
      serialized = open("https://wagon-dictionary.herokuapp.com/#{attempt}").read
      serialized_parsed = JSON.parse(serialized)
    
      if serialized_parsed["found"] && word_in_grid?(attempt, grid)
        { time: Time.now - start_time, score: 100 + attempt.length, message: 'Well Done' }
      elsif serialized_parsed["found"]
        { time: Time.now - start_time, score: 0, message: "#{attempt} is not in the grid" }
      else
        { time: Time.now - start_time, score: 0, message: "#{attempt} is not an english word" }
      end
    end
    
    @run_game = run_game(@score, @letters.split(' '), @start_time, Time.now)
  end
end
