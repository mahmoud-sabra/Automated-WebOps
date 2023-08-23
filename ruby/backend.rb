# app.rb

require 'sinatra'
require 'json'
require 'webrick'

before do
  response.headers['Access-Control-Allow-Origin'] = '*'
end
get '/health' do
  content_type :json
  { msg: 'healthy' }.to_json
end
