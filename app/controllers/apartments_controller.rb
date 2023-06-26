class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_response
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response

    def create 
        apartments = Apartment.create(apartment_params)
        render json: apartments, status: :created
    end
    
    def index 
        render json: Apartment.all
    end 

    def show 
        apartment = Apartment.find(params[:id])
        render json: apartment
    end 

    def update 
        apartment = Apartment.find(params[:id])
        apartment.update(apartment_params)
        render json: apartment, status: :ok
    end 

    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy
        head :no_content
    end

    private

    def apartment_params 
        params.permit(:number)
    end 

    def render_record_invalid_response(invalid)
        render json: { error: invalid.record.errors.full_messages}
    end 

    def render_record_not_found_response 
        render json: { error: "Apartment not found" }, status: :not_found
    end 
end
