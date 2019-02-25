class KittensController < ApplicationController
  include KittensHelper

  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.html
      format.json { render :json => @kittens }
    end
  end

  def new
    create_options_hashes
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      flash[:success] = "Kitten created"
      redirect_to @kitten
    else
      flash[:danger] = @kitten.errors.full_messages
      create_options_hashes
      render 'new'
    end
  end

  def show
    @kitten = Kitten.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @kitten }
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
    create_options_hashes
  end

  def update
    @kitten = Kitten.find(params[:id])
    @kitten.update_attributes(kitten_params)
    flash[:success] = "Kitten updated"
    redirect_to @kitten
  end

  def destroy
    Kitten.find(params[:id]).delete
    flash[:success] = "Kitten deleted"
    redirect_to kittens_path
  end

  private

    def kitten_params
      params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end
end
