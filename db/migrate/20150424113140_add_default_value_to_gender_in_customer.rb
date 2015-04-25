class AddDefaultValueToGenderInCustomer < ActiveRecord::Migration
        def up
          change_column :customers, :gender, :integer, default: 0
        end

        def down
          change_column :customers, :gender, :integer, default: nil
        end
end
