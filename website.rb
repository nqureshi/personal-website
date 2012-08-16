require 'rubygems'
require 'sinatra'
require 'haml'

get '/' do
  haml :index
end

get '/blog' do
  redirect 'http://blog.nabeelqu.com'
end

get '/quotes' do
  haml :quotes
end