class Api::V1::AuthorsController < Api::V1::BaseController
  include Pagy::Backend

  before_action :set_author, only: %i[show update destroy]

  api :GET, "/v1/authors", "List all authors with pagination"
  param :page, :number, desc: "Page number for pagination"
  def index
    @pagy, @authors = pagy(Author.all, items: 5)
    render json:            { authors: @authors, pagy: pagy_metadata(@pagy) },
           each_serializer: AuthorSerializer
  end

  api :GET, "/v1/authors/:id", "Show a single author"
  param :id, :number, required: true, desc: "ID of the author"
  def show
    render json: @author
  end

  api :POST, "/v1/authors", "Create a new author"
  param :author, Hash, desc: "Author information" do
    param :name, String, required: true, desc: "Name of the author"
    param :bio, String, desc: "Biography of the author"
  end
  def create
    author = Author.new(author_params)
    if author.save
      render json: author, status: :created
    else
      render json: author, status: :unprocessable_entity
    end
  end

  api :PUT, "/v1/authors/:id", "Update an existing author"
  param :id, :number, required: true, desc: "ID of the author"
  param :author, Hash, desc: "Author information" do
    param :name, String, required: true, desc: "Name of the author"
    param :bio, String, desc: "Biography of the author"
  end
  def update
    if @author.update(author_params)
      render json: @author, status: :ok
    else
      render json: { errors: @author.errors.full_messages }, status: :unprocessable_entity
    end
  end

  api :DELETE, "/v1/authors/:id", "Delete an author"
  param :id, :number, required: true, desc: "ID of the author"
  def destroy
    @author.destroy
    head :no_content
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name, :bio)
  end
end
