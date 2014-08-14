class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|

      t.string :query

      t.belongs_to :survey

      t.timestamp
    end
  end
end
