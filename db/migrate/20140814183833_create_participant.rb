class CreateParticipant < ActiveRecord::Migration
  def change
    create_table :participants do |t|

      t.string :name

      t.timestamp
    end
  end
end
