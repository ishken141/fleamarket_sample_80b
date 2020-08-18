class CommentsController < ApplicationController 
  def create   
    @item = Item.find(params[:item_id]) 
    @comment = Comment.create(comment_params) 
    respond_to do |format| 
      format.html { redirect_to item_path(@item)} 
      format.json
    end  
  end   
  def destroy  
    @item = Item.find(params[:item_id]) 
    @comment = @item.comments.find(params[:id]) 
    @comment.destroy 
    redirect_to item_path(@item)
  end 
  private  
  def comment_params 
    params.require(:comment).permit(:text, :item_id, :user_id).merge(user_id: current_user.id, item_id: params[:item_id])
  end 
end

