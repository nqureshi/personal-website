require 'rubygems'
require 'sinatra/base'
require 'haml'
require 'nokogiri'
require 'open-uri'

class Website < Sinatra::Base
  
  POEMS_URL = "http://rpo.library.utoronto.ca/poems"

  get('/') { haml :index }
  get('/blog') { redirect 'http://blog.nabeelqu.com' }
  get('/quotes') { haml :quotes }
  
  get '/poem' do
    @poem = Nokogiri::HTML(open(get_random_poem))
    @poem_title = @poem.css("#page-title")
    @poem_author = @poem.css(".poet-name-in-poem")
    @poem_text = @poem.css(".line-text")
    haml :poem, :layout => :poemlayout
  end
  
  helpers do
    def get_random_poem # Gets a random poem from the RPO library of poems
      poem_url = Nokogiri::HTML(open(POEMS_URL)).css("#block-system-main a")[rand(1..4785)]["href"]
      POEMS_URL.gsub("/poems", "") + poem_url
    end
  end
end