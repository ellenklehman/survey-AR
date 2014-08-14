require 'active_record'
ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])


require './lib/choice'
require './lib/question'
require './lib/response'
require './lib/survey'
require './lib/participant'

def menu
  puts "Welcome!"
  puts "If you are a survey designer, type 'd' or if you are here to take a survey, type 't'."
  choice = gets.chomp.downcase
  case choice
  when 'd'
    designer_menu
  when 't'
    taker_menu
  when 'x'
    exit
  else
    puts "Please enter a valid option."
    menu
  end
end

def designer_menu
  puts "To create a survey, type 'c', 'l' to list them, 'd' to destroy a survey.  To add questions to a survey, type 'a'. To return to the main menu, type 'm'."
  choice = gets.chomp.downcase
  case choice
  when 'c'
    create_survey
  when 'l'
    list_surveys
  when 'a'
    add_questions
  when 'd'
    destroy_survey
  when 'm'
    menu
  when 'x'
    exit
  else
    puts "Please enter a valid option"
    designer_menu
  end
  designer_menu
end


def create_survey
  puts "Name your survey"
  survey_name = gets.chomp.to_s
  new_survey = Survey.new({:name => survey_name})
    if new_survey.save
      puts 'your survey has been saved'
    else
      puts 'enter a valid option'
      new_survey.errors.full_messages.each { |message| puts message }
    end

  loop do
    puts "'add' to add another question, 'finished' to stop"
    continue = gets.chomp.to_s
    if continue == 'add'
      puts "Enter a question for #{new_survey.name}"
      q_query = gets.chomp.to_s
      new_question = Question.create({:query => q_query, :survey_id => new_survey.id})
      puts "Enter 4 possible answers to your question (hit enter between :)"
      choice1 = gets.chomp.to_s
      choice2 = gets.chomp.to_s
      choice3 = gets.chomp.to_s
      choice4 = gets.chomp.to_s
      new_choice = Choice.create({:question_id => new_question.id, :choiceA => choice1, :choiceB => choice2, :choiceC => choice3, :choiceD => choice4})
    elsif continue == 'finished'
      break
    else
      puts 'please enter a valid option'
    end
  end
  list_questions(new_survey)
end

def list_surveys
  Survey.all.each do |survey|
    puts "#{survey.id}" + '  ' + "#{survey.name}"
  end
end

def destroy_survey
  list_surveys
  puts "please enter the number of the survey you would like to delete."
  id_survey = gets.chomp.to_i
  Survey.destroy(id_survey)
end

def list_questions(survey)
  survey.questions.each do |question|
    puts question.query
  end
end

def taker_menu
  list_surveys
  puts "choose which survey number to take"
  surv_answ = gets.chomp.to_i
  current_survey = Survey.find(surv_answ)
  current_survey.questions.each do |question|
    puts question.query
    puts "1" + ' ' + "#{question.choice.choiceA}"
    puts "2" + ' ' + "#{question.choice.choiceB}"
    puts "3" + ' ' + "#{question.choice.choiceC}"
    puts "4" + ' ' + "#{question.choice.choiceD}"
    puts "What is your final answer?"
    current_response = gets.chomp.to_i
    new_response = Response.create({:survey_id => current_survey.id, :choice => current_response, :question_id => question.id})
  end
  puts "Thanks for your input"
end

menu
