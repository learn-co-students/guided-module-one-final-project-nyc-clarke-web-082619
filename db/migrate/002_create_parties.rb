class CreateParties < ActiveRecord::Migration[4.2]
    def change
        create_table :parties do |t|
            t.string :name
            t.string :time_and_date
            t.string :location
            t.integer :admission
            t.string :entertainment
            t.string :theme
            t.string :dress_code
            t.integer :host_id
        end
    end
end