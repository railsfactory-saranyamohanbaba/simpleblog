class BlogsController < ApplicationController
  before_filter :require_login
   include AuthenticatedSystem
  def index
    puts "ggggggggggggg"
    puts current_user
    @blogs=Blog.all
  end
  
  def new
    @blog=Blog.new
  end
  
  def create
    @blog=Blog.create(params[:blog])
    if @blog.save
    redirect_to(@blog, :notice=>'blog was successfully saved')
    end
  end
  
  def show
    @blog=Blog.find(params[:id])
    
  end
  
  def edit
    @blog=Blog.find(params[:id])
  end
  
  def update
    @blog=Blog.find(params[:id])
    if @blog.update_attributes(params[:blog])
      redirect_to(@blog, :notice=>'blog was successfully saved')
    end
  end
  
  def destroy
    @blog=Blog.find(params[:id])
    @blog.destroy
    redirect_to(blogs_path)
  end
end