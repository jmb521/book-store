class CreateBookFormats < ActiveRecord::Migration[7.0]
  def change
    create_table :book_formats do |t|
      t.belongs_to :book
      t.belongs_to :book_format_type

      t.timestamps
    end
  end
end
