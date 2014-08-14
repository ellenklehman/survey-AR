require 'active_record'
require 'rspec'
require 'pry'

require 'choice'
require 'question'
require 'response'
require 'survey'
require 'participant'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Choice.all.each { |task| task.destroy }
    Response.all.each { |task| task.destroy }
    Question.all.each { |task| task.destroy }
    Survey.all.each { |task| task.destroy }
  end
end
