class ChangeDataTypeForPostcode < ActiveRecord::Migration
  def change
        change_table :customers do |t|
                t.change :postcode, :string
        end
  end
end
