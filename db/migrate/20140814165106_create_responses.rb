class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|

      t.string :choice

      t.belongs_to :survey
      t.belongs_to :question

      t.timestamp
    end
  end
end
