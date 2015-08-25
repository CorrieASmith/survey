ENV['RACK_ENV'] = 'development'
require('sinatra/activerecord')
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/survey')
require('.lib/question')
require('pg')
require('pry')

get('/') do
  @question = Question.all()
  @survey = Survey.all()
  erb(:index)
end
