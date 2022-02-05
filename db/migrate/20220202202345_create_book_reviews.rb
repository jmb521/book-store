class CreateBookReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :book_reviews do |t|
      t.belongs_to :book
      t.integer :rating, null: false
      

      t.timestamps
    end
  end
end
