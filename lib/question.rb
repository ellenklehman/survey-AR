class Question < ActiveRecord::Base

  belongs_to :survey

  has_one :choice
  has_one :response

end
