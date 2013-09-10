class PantriesController < ApplicationController

  def index
    @pantries = Pantry.all
    @uploader = Pantry.new.pasta
    @uploader.success_action_redirect = new_pantry_url
  end

  def new
    @pantry = Pantry.new(key: params[:key])
  end

  def create
    @pantry = Pantry.create(params[:pantry])
    if @pantry.save
       flash[:notice] = "Hooray! Pasta added!"
       redirect_to pantry_url
     else
       flash[:alert] = "Pasta not added"
       render action: "new"
     end
  end

  def show
    @pantry = Pantry.find(params[:id])
  end

  def edit
    @pantry = Pantry.find(params[:id])
  end

  def update
    @pantry = Pantry.find(params[:id])
    if @pantry.update_attributes(params[:pantry])
      redirect_to @pantry, notice: 'Pantry was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @pantry = Pantry.find(params[:id])
    @pantry.destroy
      redirect_to pantries_url
  end
end
