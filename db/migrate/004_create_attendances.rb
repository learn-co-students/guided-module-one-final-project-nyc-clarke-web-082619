class CreateAttendances < ActiveRecord::Migration[4.2]
    def change
        create_table :attendances do |t|
            t.integer :party_id
            t.integer :guest_id
        end
    end
end