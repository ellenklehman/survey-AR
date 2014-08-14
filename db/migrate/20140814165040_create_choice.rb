class CreateChoice < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.string :choiceA
      t.string :choiceB
      t.string :choiceC
      t.string :choiceD

      t.belongs_to :question

      t.timestamp
    end
  end
end
