class TotalSpotItemsController < ApplicationController
  before_action :require_login
  before_action :set_item, only: %i[update destroy]

  def index
    @total_spot_items = current_user.total_spot_items.all.order(:position).includes(:user, :recommended_spot,
                                                                                    :tourist_spot)
    @model_course = ModelCourse.new
  end

  def create
    existing_item = TotalSpotItem.find_existing_item(current_user, total_spot_item_params)
  
    if existing_item
      flash[:danger] = if total_spot_item_params[:tourist_spot_id]
        t('.duplicate_tourist_spot', tourist_spot_name: existing_item.tourist_spot.name)
      else total_spot_item_params[:recommended_spot_id]
        t('.duplicate_recommended_spot', recommended_spot_name: existing_item.recommended_spot.name)
      end
  
      redirect_to request.referer
    else
      flash[:success] = t('.success')
      redirect_to request.referer
  
      @total_spot_item = current_user.total_spot_items.build(total_spot_item_params)
      @total_spot_item.insert_at(current_user.total_spot_items.count + 1)
      @total_spot_item.save
    end
  end

  def update
    params[:total_spot_item][:transportation] = TotalSpotItem.transportations[params[:total_spot_item][:transportation]]
    if @total_spot_item.update(total_spot_item_params)
      flash[:success] = t('.update.success')
    else
      flash[:danger] = t('.update.fail')
    end
    redirect_to total_spot_items_path
  end

  def destroy
    @total_spot_item.destroy
    redirect_to request.referer, success: t('.delete_success')
  end

  def sort
    @total_spot_item = TotalSpotItem.find(params[:id].to_i)
    @total_spot_item.insert_at(params[:to].to_i + 1)
    head :ok
  end

  def get_total_spot_items_count
    count = current_user.total_spot_items.count
    render json: { count: }
  end

  private

  def total_spot_item_params
    params.require(:total_spot_item).permit(:recommended_spot_id, :tourist_spot_id, :duration, :transportation)
          .tap { |params| params[:transportation] = params[:transportation].to_i }
  end

  def total_spot_item_update_params
    params.require(:total_spot_items).permit(total_spot_items: %i[duration transportation])
  end

  def set_item
    @total_spot_item = current_user.total_spot_items.find(params[:id].to_i)
  end
end
