ENV['RACK_ENV'] = 'development'
require('sinatra/activerecord')
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/survey')
require('./lib/question')
require('pg')
require('pry')

get('/') do
  erb(:index)
end

get('/surveys') do
  @surveys = Survey.all()
  erb(:survey)
end

post('/surveys') do
  name = params.fetch("name")
  survey = Survey.create({:name => name, :num_questions => 0})
  @surveys = Survey.all()
  erb(:survey)
end

get('/surveys/:id') do
  @id = params['id'].to_i
  @surveys = Survey.find(params.fetch('id').to_i)
  @questions = @surveys.questions()
  erb(:question)
end

post('/surveys/:id') do
  @id = params['id'].to_i
  question = params['question']
  Question.create({:question => question, :survey_id => @id})
  survey = Survey.find(@id)
  num_questions = survey.num_questions + 1
  survey.update({:num_questions => num_questions})
  @surveys = Survey.find(@id.to_i)
  @questions = survey.questions()
  erb(:question)
end
