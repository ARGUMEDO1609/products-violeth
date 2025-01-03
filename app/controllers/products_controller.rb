class ProductsController < ApplicationController
  before_action :check_admin_priv, except: ["index", "show"]
  before_action :set_product, only: %i[ show edit update destroy ]

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
  
    respond_to do |format|
      if @product.save
        size_ids = params[:product][:size_ids] || []
        @product.sizes << Size.where(id: size_ids) unless size_ids.empty?
  
        format.html { redirect_to @product, notice: "Product was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    new_product_params = product_params.to_unsafe_h
    new_product_params.delete("images") if new_product_params["images"].all?(&:blank?)
    respond_to do |format|
      if @product.update(new_product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end
  

  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, status: :see_other, notice: "Product was successfully destroyed." }
    end
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :category_id, :available_sizes, images: [] )
    end
end
