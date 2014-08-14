require 'spec_helper'

describe Survey do
  it "validates presence of name" do
    survey = Survey.new({:name => ''})
    survey.save.should eq false
  end
end
