require 'spec_helper'

describe Response do
  describe '.total_participants' do
    it "returns number of participants that took a survey" do
      survey = Survey.new({:name => 'Survey1'})
      survey.save
      participant = Participant.create({:name => "George"})
      participant2 = Participant.create({:name => "Geo"})
      response = Response.create({:survey_id => survey.id, :choice => 'choice1', :question_id => 1, :participant_id=>participant.id})
      response2 = Response.create({:survey_id => survey.id, :choice => 'choice1', :question_id => 1, :participant_id=>participant2.id})
      expect(Response.total_participants(survey.id)).to eq 2
    end
  end

  describe '.question_ans' do
    it 'returns number of responses per answer choice' do
      survey = Survey.new({:name => 'Survey1'})
      survey.save
      participant = Participant.create({:name => "George"})
      participant2 = Participant.create({:name => "Geo"})
      question = Question.create({:query => 'Favorite color?', :survey_id => survey.id})
      question2 = Question.create({:query => 'Favorite candy?', :survey_id => survey.id})
      choice = Choice.create({:question_id => question.id, :choiceA => 1, :choiceB => 2, :choiceC => 3, :choiceD => 4})
      response = Response.create({:survey_id => survey.id, :choice => 1, :question_id => question.id, :participant_id=>participant.id})
      response2 = Response.create({:survey_id => survey.id, :choice => 1, :question_id => question2.id, :participant_id=>participant2.id})
      response2 = Response.create({:survey_id => survey.id, :choice => 1, :question_id => question.id, :participant_id=>participant2.id})
      expect(Response.question_ans(survey.id)).to eq [1,1,0,0]
    end
  end
end
