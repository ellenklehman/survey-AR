class Response < ActiveRecord::Base

  belongs_to :question
  belongs_to :survey
  belongs_to :participants

  def self.total_participants(surveyID)
    survey_responses = self.where(:survey_id => surveyID)
    array = []
    survey_responses.each do |specific_responses|
      array << specific_responses.participant_id
    end
    array.uniq!
    unique_participants = array.length
  end

  def self.question_ans(surveyID)
    survey_responses = self.where(:survey_id => surveyID)
    questions = []
    survey = Survey.where(:id => surveyID)
binding.pry
    survey_responses.each do |response|
      questions << [response.question_id, response.choice]
    end
    questions.sort!
  end
end

# survey.first.questions.each do |question|

