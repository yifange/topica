class Api::V1::FavorsController < Api::V1::ApplicationController
  def index
    post_ids = Favor.where(:user_id => params[:user_id]).map(&:post_id)
    posts = Post.where(:id => post_ids)
    render :json => posts
  end
  def all_favorers
    user_ids = Favor.where(:post_id => params[:post_id]).map(&:user_id)
    users = User.where(:id => user_ids).select(:id, :email, :username)
    render :json => users
  end
  def create
    favor = Favor.new(:user_id => params[:user_id], :post_id => params[:post_id])
    if favor.save
      render :json => favor, :status => :created
    else
      render :json => {:ok => false, :message => favor.errors}, :status => :unprocessable_entity
    end
    # post_ids = params[:post_ids]
    # favors = []
    # post_ids.each do |post_id|
    #   favors << Favor.new(:user_id => params[:user_id], :post_id => post_id)
    # end
    # import_result = Favor.import(favors)
    # if import_result.failed_instances.empty?
    #   render :json => {:ok => true, :num_inserts => import_result.num_inserts}, :status => :created
    # else
    #   render :json => {:ok => false, :num_inserts => import_result.num_inserts, :failed_instances => import_result.failed_instances.map {|i| i.post_id}}, :status => :unprocessable_entity
    # end
  end
  def destroy
    favor = Favor.where(:user_id => params[:user_id], :post_id => params[:post_id])
    favor.destroy
    render :json => {:ok => true}, :head => :no_content
  end
end
