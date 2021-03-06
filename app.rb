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

get('/surveys/:id/delete') do
  survey = Survey.find(params['id'].to_i)
  @surveys = Survey.all()
  survey.destroy
  erb(:survey)
end

get('/surveys/:id/edit') do
  @survey = Survey.find(params["id"].to_i)
  erb(:survey_edit)
end

patch('/surveys') do
  name = params.fetch("name")
  id = params.fetch("id").to_i()
  survey = Survey.find(id)
  survey.update({:name => name})
  @surveys = Survey.all()
  erb(:survey)
end

patch('/surveys/:id') do
  @id = params['id'].to_i
  question_id = params['question_id'].to_i
  question = Question.find(question_id)
  question.update({:question => params['question']})
  @surveys = Survey.find(question.survey_id)
  @questions = @surveys.questions()
  erb(:question)
end

get('/questions/:id/delete') do
  question = Question.find(params['id'].to_i)
  @id = question.survey_id
  @questions = Question.all()
  question.destroy
  erb(:question)
end

get('/questions/:id/edit') do
  @question = Question.find(params['id'].to_i)
  erb(:question_edit)
end

patch('/questions') do
  question = params.fetch("question")
  id = params.fetch("id").to_i()
  questions = Question.find(id)
  questions.update({:question => question})
  @id = questions.survey_id
  @question = Question.all()
  erb(:question)
end

get('/surveys/:id/take_survey') do
  @survey = Survey.find(params['id'].to_i)
  @questions = @survey.questions
  erb(:take_survey)
end
