class CustomersController < ApplicationController
  PAGE_SIZE = 10

  def index

    if params[:keywords].present?
      @page = (params[:page] || 0).to_i

      @keywords = params[:keywords]
      customer_search_term = CustomerSearchTerm.new(@keywords)
      @search_return = Customer.where(
          customer_search_term.where_clause,
          customer_search_term.where_args).
        order(customer_search_term.order)
      @customers = @search_return.offset(PAGE_SIZE * @page)
                                 .limit(PAGE_SIZE)
      @total_pages = @search_return.count / PAGE_SIZE
    else
      @customers = []
      @page = 0
      @total_pages = 0
    end

    # Respond to json requests
    respond_to do |format|
      format.html {}
      format.json { render json: @customers }
    end
  end
end