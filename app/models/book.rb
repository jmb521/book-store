class Book < ApplicationRecord
    has_many :book_formats
    has_many :book_format_types, through: :book_formats
    has_many :book_reviews
    belongs_to :publisher
    belongs_to :author
    
    validates_presence_of :title, :publisher_id, :author_id    
    

    scope :search_author, -> (term) {joins(:author).where("lower(last_name) = ?", term.downcase)}
    scope :search_publisher, -> (term) {joins(:publisher).where("lower(name) = ?", term.downcase)}
    scope :search_title, -> (term) {where("lower(title) LIKE ? ", "%#{term.downcase}%")}
    scope :find_by_book_format_type_id, -> (id) {joins(:book_formats).where(book_formats: {book_format_type_id: id})}
    scope :find_by_book_format_physical, -> (bool) {joins(:book_format_types).where("physical = ?", bool)}
    

    def author_name
        "#{self.author.last_name}, #{self.author.first_name}"
    end
    
    def average_rating
        self.book_reviews.average("rating").to_f.truncate(1)
    end

    def self.search(search_term, title_only: false, book_format_physical: nil, book_format_id: nil)
        
        if title_only
            results = Book.search_title(search_term)
        else
            results = Book.search_title(search_term)
            results = Book.search_author(search_term) if results.length < 1
            results = Book.search_publisher(search_term) if results.length < 1
            results = results.find_by_book_format_physical(book_format_physical) if !book_format_physical.nil?
            results = results.find_by_book_format_type_id(book_format_id) if book_format_id
        end
        results.sort{|a, b| b.average_rating <=> a.average_rating}.uniq
    end
end
