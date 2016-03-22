require 'erb'
require 'pry'
class SiteGenerator
  def make_index!
    fileHtml = File.new("_site/index.html", "w+")
    fileHtml.puts "<!DOCTYPE html>"
    fileHtml.puts "<html>"
    fileHtml.puts "  <head>"
    fileHtml.puts "    <title>Movies</title>"
    fileHtml.puts "  </head>"
    fileHtml.puts "  <body>"
    fileHtml.puts "    <ul>"
    Movie.all.each do |movie|
      fileHtml.puts %Q[      <li><a href="movies/#{movie.url}">] + movie.title + "</a></li>"
    end
    fileHtml.puts "    </ul>"
    fileHtml.puts "  </body>"
    fileHtml.puts "</html>"
    fileHtml.close()
  end
  
  def generate_pages!
    Dir.mkdir '_site/movies' unless Dir.exists?('_site/movies')
    html = File.read('lib/templates/movie.html.erb')
    erb = ERB.new(html)
    Movie.all.each do |movie|
      fileHtml = File.new("_site/movies/#{movie.url}", "w+")
      fileHtml.puts erb.result(binding)
      fileHtml.close()
    end  
  end
end