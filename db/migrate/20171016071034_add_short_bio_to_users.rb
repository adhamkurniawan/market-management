class AddShortBioToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :short_bio, :string
  end
end
