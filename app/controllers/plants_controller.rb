class PlantsController < ApplicationController
  
  def index
    plants = Plant.all
    render json: plants
  end

  
  def show
    plant = Plant.find_by(id: params[:id])
    if plant
      render json: plant
    else
      render json: { error: 'Plant not found' }, status: :not_found
    end
  end

  
  def create
    plant = Plant.create(plant_params)
    if plant.valid?
      render json: plant, status: :created
    else
      render json: { errors: plant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  
  def update
    plant = Plant.find_by(id: params[:id])
    if plant
      if plant.update(plant_params)
        render json: plant
      else
        render json: { errors: plant.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Plant not found' }, status: :not_found
    end
  end

  
  def destroy
    plant = Plant.find_by(id: params[:id])
    if plant
      plant.destroy
      head :no_content
    else
      render json: { error: 'Plant not found' }, status: :not_found
    end
  end

  private

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end
end