class LeasesController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_response

    def create 
        leases = Lease.create(leases_params)
        render :json leases, status: :created
    end 

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    end 

    private 

    def leases_params 
        params.permit(:rent, :apartment_id, :tenant_id)
    end 

    def render_record_invalid_response(invalid)
        render json: { error: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end 
end
