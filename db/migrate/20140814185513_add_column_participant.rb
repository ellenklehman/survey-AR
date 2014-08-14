class AddColumnParticipant < ActiveRecord::Migration
  def change

    add_column :responses, :participant_id, :integer
  end
end
