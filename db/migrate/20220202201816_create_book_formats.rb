class CreateBookFormats < ActiveRecord::Migration[7.0]
  def change
    create_table :book_formats do |t|
      t.belongs_to :books
      t.belongs_to :book_format_types

      t.timestamps
    end
  end
end
