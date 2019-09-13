class CreateHosts < ActiveRecord::Migration[4.2]
    def change
        create_table :hosts do |t|
            t.string :username
        end
    end
end