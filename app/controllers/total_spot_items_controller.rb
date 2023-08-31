class TotalSpotItemsController < ApplicationController
  before_action :require_login
  
  def index
    @total_spot_items = current_user.total_spot_items.all.order(:position)
    @model_course = ModelCourse.new
  end

  def create
    existing_item = current_user.total_spot_items.find_by(
        tourist_spot_id: total_spot_item_params[:tourist_spot_id],
        recommended_spot_id: total_spot_item_params[:recommended_spot_id]
    )
        
    if existing_item

      if total_spot_item_params[:tourist_spot_id]
        flash[:danger] = t('.duplicate_tourist_spot')
        redirect_to tourist_spots_path
      elsif total_spot_item_params[:recommended_spot_id]
        flash[:danger] = t('.duplicate_recommended_spot')
        redirect_to recommended_spots_path
      end

    else
      @total_spot_item = current_user.total_spot_items.build(total_spot_item_params)
      @total_spot_item.insert_at(current_user.total_spot_items.count + 1)
          
      if @total_spot_item.save
        flash[:success] = t('.success')
        if total_spot_item_params[:tourist_spot_id]
          redirect_to tourist_spots_path
        elsif total_spot_item_params[:recommended_spot_id]
          redirect_to recommended_spots_path
        end
      end
    end
  end

  def update
    @total_spot_item = current_user.total_spot_items.find(params[:id].to_i)
    params[:total_spot_item][:transportation] = TotalSpotItem.transportations[params[:total_spot_item][:transportation]].to_i

    if @total_spot_item.update(total_spot_item_params)
      flash[:success] = t('.update.success')
    else
      flash[:danger] = t('.update.fail')
    end
  
    redirect_to total_spot_items_path
  end
  
  def destroy
    @total_spot_item = current_user.total_spot_items.find(params[:id])
    @total_spot_item.destroy
    redirect_to request.referer, success: t('.delete.success')
  end

  def sort
    @total_spot_item  = TotalSpotItem.find(params[:id].to_i)
    @total_spot_item.insert_at(params[:to].to_i + 1)
    head :ok
  end

  private
  
  def total_spot_item_params
    params.require(:total_spot_item).permit(:recommended_spot_id, :tourist_spot_id, :duration, :transportation)
          .tap { |params| params[:transportation] = params[:transportation].to_i }
  end
  
  def total_spot_item_update_params
    params.require(:total_spot_items).permit(total_spot_items: [:duration, :transportation])
  end
end
