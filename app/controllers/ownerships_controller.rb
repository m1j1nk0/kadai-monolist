class OwnershipsController < ApplicationController
  def create
    @item = Item.find_or_initialize_by(code: params[:item_code])
    
    unless @item.persisted?
      results = RakutenWebService::Ichiba::Item.search(itemCode: @item.code)
      
      @item = Item.new(read(results.first))
      @item.save
    end
    
    if params[:type] == "Want"
      current_user.want(@item)
      flash[:success] = "Wantしました"
    elsif params[:type] == "Have"
      current_user.have(@item)
      flash[:success] = "Haveしました"
    end
    
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @item = Item.find(params[:item_id])
    
    if params[:type] == "Want"
      current_user.unwant(@item)
      flash[:success] = "want解除"
    elsif params[:type] == "Have"
      current_user.unhave(@item)
      flash[:success] = "want解除"
    end
    
    redirect_back(fallback_location: root_path)
  end
end
