require 'rubygems'
require 'sinatra/base'
require 'haml'
require 'nokogiri'
require 'open-uri'
require 'kramdown'
require 'yaml'
require File.dirname(__FILE__) + '/lib/blog/' + 'post'

module Nabeel
  class Website < Sinatra::Base
  
    POEMS_URL = "http://rpo.library.utoronto.ca/poems"
  
    PUBLIC_DIR    = File.join(APP_DIR, 'public')
    VIEW_DIR      = File.join(APP_DIR, 'views')
    CONTENT_FILE  = File.join(APP_DIR, 'posts.yaml')

    get('/')        { haml :index }
    get('/quotes/?')  { haml :quotes }
    
    get '/blog/?' do
      erb :blog, :layout => :bloglayout
    end
  
    get Post::ROUTE do
      @post = posts.find { |p| p.slug  == params[:slug] }
      erb :post, :layout => :bloglayout
    end
  
    get '/poem/?' do
      get_poem_data
      haml :poem, :layout => :poemlayout
    end
  
    helpers do
      
      def content
        @content || YAML.load(File.read(CONTENT_FILE))
      end
    
      def posts
        @posts || content.each.map(&Post.method(:new))
      end
    
      def get_random_poem # Return URL of random poem
        poem_url = Nokogiri::HTML(open(POEMS_URL)).css("#block-system-main a")[rand(1..4785)]["href"]
        POEMS_URL.gsub("/poems", "") + poem_url
      end
    
      def get_poem_data
        @poem = Nokogiri::HTML(open(get_random_poem))
        @poem_title = @poem.css("#page-title")
        @poem_author = @poem.css(".poet-name-in-poem")
        @poem_text = @poem.css(".line-text")
      end
    
    end
  end
end