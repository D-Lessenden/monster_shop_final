class Merchant::DiscountsController < Merchant::BaseController

  def index
    @discounts = current_user.merchant.discounts
  end

  def show
     @discount = Discount.find(params[:discount_id])
  end

  def new
    @discount = Discount.new
  end

  def create
    merchant = current_user.merchant
    @discount = merchant.discounts.new(discount_params)
    if @discount.save
      redirect_to "/merchant/discounts"
    else
      flash[:error] = @discount.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @discount = Discount.find(params[:discount_id])
  end

  def update
    @discount = Discount.find(params[:discount_id])
    if @discount.update(discount_params)
      redirect_to "/merchant/discounts"
    else
      flash[:error] = @discount.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    Discount.destroy(params[:discount_id])
    redirect_to "/merchant/discounts"
  end

  private
  def discount_params
    params.permit(:name, :percent, :num_of_items)
  end
end
