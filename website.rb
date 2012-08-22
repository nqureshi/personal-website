require 'rubygems'
require 'sinatra/base'
require 'haml'

class Website < Sinatra::Base

  get '/' do
    haml :index
  end

  get '/blog' do
    redirect 'http://blog.nabeelqu.com'
  end

  get '/quotes' do
    haml :quotes
  end
  
  get '/writings' do
    haml :writings
  end

end