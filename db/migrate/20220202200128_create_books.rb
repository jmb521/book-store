class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.belongs_to :publisher
      t.belongs_to :author

      t.timestamps
    end
  end
end
