require 'uri'
require 'pry'

class Movie
  
  attr_accessor :title, :release_date, :director, :summary
  @@all = []
  
  def initialize(title, release_date, director, summary)
    @title = title
    @release_date = release_date.to_i
    @director = director
    @summary = summary
    @@all << self
  end
  
  def url
    filename = title.split(' ').join('_').downcase
    url = "#{filename}.html"
    URI.encode(url, /(?!\.)\W/)
  end
  
  def self.all
    @@all
  end
  
  def self.reset_movies!
    @@all.clear
  end
  
  def self.make_movies!
    File.open('./spec/fixtures/movies.txt').each do |line|
      m = line.split(' - ')
      movie = Movie.new(m[0], m[1], m[2], m[3])
    end
  end
  
  def self.recent
    self.all.select { |movie| movie.release_date >= 2012 }
  end
  
end