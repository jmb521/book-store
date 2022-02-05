class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.belongs_to :publishers
      t.belongs_to :authors

      t.timestamps
    end
  end
end
