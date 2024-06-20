class Api::V1::BooksController < Api::V1::BaseController

  before_action :set_book, only: %i[show update destroy]

  api :GET, "/v1/authors/:author_id/books", "List all books for an author with pagination"
  param :author_id, :number, required: true, desc: "ID of the author"
  param :page, :number, desc: "Page number for pagination"
  returns code: 200, desc: "Ok"
  returns code: 404, desc: "Not Found"
  returns code: 500, desc: "Internal Server Error"

  def index
    @pagy, @books = pagy(Book.where(author_id: params[:author_id]), items: 5)
    render json: { books: @books, pagy: pagy_metadata(@pagy) }, each_serializer: Api::V1::BookSerializer
  end

  api :GET, "/v1/books/:id", "Show a single book"
  param :id, :number, required: true, desc: "ID of the book"
  returns code: 200, desc: "Ok"
  returns code: 404, desc: "Not Found"
  returns code: 500, desc: "Internal Server Error"

  def show
    render json: @book
  end

  api :POST, "/v1/authors/:author_id/books", "Create a new book for an author"
  param :author_id, :number, required: true, desc: "ID of the author"
  param :book, Hash, desc: "Book information" do
    param :title, String, required: true, desc: "Title of the book"
    param :description, String, desc: "Description of the book"
  end
  returns code: 201, desc: "Created"
  returns code: 422, desc: "Unprocessable Entity"
  returns code: 500, desc: "Internal Server Error"

  def create
    @book = Book.new(book_params)
    @book.author_id = params[:author_id]
    if @book.save
      render json: @book, status: :created
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  api :PUT, "/v1/books/:id", "Update an existing book"
  param :id, :number, required: true, desc: "ID of the book"
  param :book, Hash, desc: "Book information" do
    param :title, String, required: true, desc: "Title of the book"
    param :description, String, desc: "Description of the book"
  end
  returns code: 200, desc: "Ok"
  returns code: 404, desc: "Not Found"
  returns code: 422, desc: "Unprocessable Entity"
  returns code: 500, desc: "Internal Server Error"

  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, "/v1/books/:id", "Delete a book"
  param :id, :number, required: true, desc: "ID of the book"
  returns code: 204, desc: "No Content"
  returns code: 404, desc: "Not Found"
  returns code: 500, desc: "Internal Server Error"

  def destroy
    book_title = @book.title
    @book.destroy
    render json: { message: "#{book_title} successfully deleted" }, status: :ok
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :description)
  end
end
