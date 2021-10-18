class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  
    def index
      render json: Apartment.all
    end
  
    def show
      apt = find_apt
      render json: apt
    end
  
    def create
        apt = Apartment.create!(apt_params)
      render json: apt, status: :created
    end

    def update
        apt = Apartment.find(params[:id])
        apt.update!(apt_params)
        render json: apt, status: :accepted
    end

    def destroy
        apt = find_apt
        apt.destroy
        head :no_content
    end
  
    private
  
    def apt_params
      params.permit(:number)
    end
    
    def find_apt
        Apartment.find(params[:id])
    end
  
    def render_not_found_response
      render json: { error: "apt not found" }, status: :not_found
    end
  
    def render_unprocessable_entity_response(exception)
      render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
end
