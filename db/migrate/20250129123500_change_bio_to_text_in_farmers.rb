class ChangeBioToTextInFarmers < ActiveRecord::Migration[7.1]
  def change
    change_column :farmers, :bio, :text
  end
end
