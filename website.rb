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
    
    get '/songbook' do
      haml :songbook, :layout => :poemlayout
    end
  
    helpers do
      
      def content
        @content || YAML.load(File.read(CONTENT_FILE))
      end
    
      def posts
        @posts || content.each.map(&Post.method(:new))
      end
    
    end
  end
end