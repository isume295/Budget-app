class CategoriesController < ApplicationController
  before_action :authenticate_user!

  # GET /categories or /categories.json
  def index
    @categories = Category.where(user_id: current_user.id)
    @exchanges_by_category = {}

    @categories.each do |category|
      @exchanges_by_category[category.id] = category.exchanges
    end
  end

  # GET /categories/1 or /categories/1.json
  def show; end

  # GET /categories/new
  def new
    @user = current_user
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit; end

  # POST /categories or /categories.json
  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      # Category successfully created
      flash[:notice] = 'Category created successfully.'
      redirect_to user_categories_path(current_user)
    else
      # Handle validation errors
      flash[:notice] = 'Category not created successfully.'
      render :new
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to category_url(@category), notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
