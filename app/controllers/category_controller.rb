class CategoryController < ApplicationController
	 before_action :authenticate_admin! # here authenticate admin before action
	 #skip_before_action :authenticate_user! # here skip authenticate user in all methods


	  def new
        @category = Category.new
        @cat=Category.all
       
    end

    def create
      @category = Category.new(category_params)
      @category.save!
      
       flash[:success] = 'Category is uploaded.'
      #redirect_to @category
      @cat=Category.all
    end

    def show
      @category =Category.all      
    end

    def destroy
      @deletecat= params[:id]
      @category = Category.find(params[:id])
      @category.destroy

    end

     private
    

    def category_params
        params.require(:category).permit(:cat_name)
    end

end
