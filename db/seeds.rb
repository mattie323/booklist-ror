# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
Author.destroy_all
Book.destroy_all

# Sample data
author_names = [
  "J.K. Rowling", 
  "George R.R. Martin", 
  "J.R.R. Tolkien",
  "Agatha Christie", 
  "Stephen King", 
  "Jane Austen",
  "Mark Twain", 
  "Ernest Hemingway", 
  "F. Scott Fitzgerald", 
  "Charles Dickens"
]

book_titles = [
  "A Tale of Two Cities", 
  "Pride and Prejudice", 
  "The Hobbit",
  "The Catcher in the Rye", 
  "To Kill a Mockingbird", 
  "1984",
  "The Great Gatsby", 
  "Moby-Dick", 
  "War and Peace", 
  "Ulysses"
]

# Create authors
authors = []
author_names.each do |name|
  authors << Author.create!(
    name: name,
    bio: "Biography of #{name}"
  )
end

# Create books
authors.each_with_index do |author, index|
  1.upto(10) do |i|
    author.books.create!(
      title: "#{book_titles[index]} #{i}",
      description: "Description of #{book_titles[index]} #{i}"
    )
  end
end

puts "Created #{Author.count} authors"
puts "Created #{Book.count} books"