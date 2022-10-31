class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_message

  def show
    user = User.find_by(id: params[:id])
    render json: user, include: :items
  end

  def item_index
    items = Item.where(user_id: params[:user_id])
    if(User.find(params[:user_id]))
      render json: items
    else
      render_not_found_message
    end
  end

  def item_show
    item = Item.find_by(user_id: params[:user_id], id: params[:id])
    if(item)
      render json: item
    else
      render json: {error: "Item not found"}, status: :not_found
    end
  end

  def item_create
    if(User.find(params[:user_id]))
      item = Item.create(name: params[:name], description: params[:description], price: params[:price], user_id: params[:user_id])
      render json: item, status: :created
    else
      render_not_found_message
    end
  end

  private

  def render_not_found_message
    render json: {error: "User not found"}, status: :not_found
  end

end
