class BookReview < ApplicationRecord
    belongs_to :book
    validates :rating, numericality: {only_integer: true}
    validates_inclusion_of :rating, :in => 1..5
end
