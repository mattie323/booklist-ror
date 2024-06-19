class Api::V1::BaseController < ApplicationController
  include Pagy::Backend

  private

  def pagy_metadata(pagy)
    {
      count: pagy.count,
      page:  pagy.page,
      items: pagy.items,
      pages: pagy.pages,
      next:  pagy.next,
      prev:  pagy.prev
    }
  end
end
