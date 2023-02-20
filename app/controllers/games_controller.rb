class GamesController < ApplicationController
  def new
    @letters = generate_letter
  end

  def score
    if check_grid == true
      @answer = "Sorry but #{params[:answer].upcase} can't be build out of #{params[:letters].upcase}."
    elsif parsing == false
      @answer = "Sorry but #{params[:answer].upcase} does not seem to ba a valid english word.."
    else
      @answer = "Congratulations! #{params[:answer].upcase} is a valid english word!"
    end
  end

  private

  def generate_letter
    @array = []
    10.times do
      letter = ('a'..'z').to_a.sample
      @array << letter
    end
    @array
  end

  def check_grid
    results = []
    word = params[:answer].split("")
    array = params[:letters].split(", ")
    word.each do |letter|
      results << array.include?(letter)
    end
    results.include?(false)
  end

  def parsing
    url = "https://wagon-dictionary.herokuapp.com/#{params[:answer]}"
    parse_serialized = URI.open(url).read
    parse = JSON.parse(parse_serialized)
    parse["found"]
  end

end
