class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|

      t.string :name

      t.timestamp
    end
  end
end
